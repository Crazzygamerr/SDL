
import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdl/NearbyService.dart';

class CreateForm extends StatefulWidget {
  // final FormType formType;
  
  const CreateForm({
    Key? key,
    // required this.formType
  }) : super(key: key);
  
  @override
  State<CreateForm> createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NearbyService>().removeListener(catchError);
      context.read<NearbyService>().removeListener(goToConnectedPage);
      context.read<NearbyService>().addListener(catchError);
      context.read<NearbyService>().addListener(goToConnectedPage);
    });
  }

  void catchError() {
    if(!mounted) return;
    if(context.read<NearbyService>().error != null) {
      // if(context.read<NearbyService>().isAdvertising) {
      //   context.read<NearbyService>().startAdvertising(form);
      // }
      context.read<NearbyService>().error = null;
    }
  }
  
  void goToConnectedPage() {
    if(!mounted) return;
    if(
      context.read<NearbyService>().connectedDevices.isNotEmpty 
      && isSharing 
      && !context.read<NearbyService>().payloads[0].containsKey("contentType")
    ) {
      Provider.of<NearbyService>(context, listen: false).payloads = [{"type": "share", "contentType": "ack"}];
      Navigator.of(context).pushNamed('/responsePage').then((value) {
        context.read<NearbyService>().payloads = [{}];
        NearbyService().stopAllEndpoints();
        NearbyService().startAdvertising(shareMsg, isSharing: true);
      });
    }
  }

  @override
  void dispose() {
    NearbyService().stopAdvertising();
    NearbyService().stopDiscovery();
    NearbyService().stopAllEndpoints();
    // context.read<NearbyService>().removeListener(catchError);
    // context.read<NearbyService>().removeListener(goToConnectedPage);
    super.dispose();
  }
  
  Map<String, dynamic> shareMsg = {
    "type": "share",
    "contentType": "ack",
  };
  Map<String, dynamic> form = {
    "type": "form",
    "title": "Untitled Form",
    "username":'',
    "description": "",
    "content": [
      {
        "type": QuestionTypes.singleLine.value,
        "title": "Untitled Question",
        "options": [
          "Option 1"
        ],
      }
    ],
  };
  
  bool isSharing = false;
  TextEditingController titleController = TextEditingController(text: "Untitled Form"), descriptionController = TextEditingController();
  TextEditingController titleControllerr = TextEditingController(text: "Untitled Form"), descriptionControllerr = TextEditingController();
  List<List<TextEditingController>> optionControllers = [[TextEditingController(text: "Option 1")]];

  @override
  Widget build(BuildContext context) {
     List<Map<String, dynamic>> payloads = context.watch<NearbyService>().payloads;
     //print(form);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Create Form'),
      ),

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: isSharing,
                    onChanged: (v) => setState(() => isSharing = v as bool),
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text("Share"),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text("Form"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              if(!isSharing)
              ...[
                TextFormField(
                  //initialValue: ,
                  decoration: const InputDecoration(
                    labelText: 'Form Title',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(),
                  ),
                  controller: titleController,
                  onChanged: (v) => setState(() => form["title"] = v),
                ),
                const SizedBox(height: 10),
                TextFormField(
                //initialValue: ,
                //enabled:false,
                decoration: const InputDecoration(
                    labelText: 'Username',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(),
                  ),
                  controller: titleControllerr..text=Provider.of<NearbyService>(context, listen: false).userName.toString(),
                  onChanged: (v) => Provider.of<NearbyService>(context, listen: false).userName=v,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: descriptionController,
                  onChanged: (v) => setState(() => form["description"] = v),
                  decoration: const InputDecoration(
                    labelText: 'Form Description',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  itemCount: form["content"].length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Question Title',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => setState(() {
                                    form["content"].removeAt(index); 
                                    optionControllers.removeAt(index);
                                  }),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Question Type: "),
                                DropdownButton(
                                  items: QuestionTypes.values.map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: Text(e.name),
                                  )).toList(),
                                  onChanged: (v) => setState(() { form["content"][index]["type"] = v;

                                  }),
                                  value: form["content"][index]["type"],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Is Required: "),
                                Switch(
                                  value: form["content"][index]["isRequired"] ?? false,
                                  onChanged: (v) => setState(() => form["content"][index]["isRequired"] = v),

                                ),

                              ],

                            ),

                            if(
                              form["content"][index]["type"] == QuestionTypes.multipleChoice.value
                              || form["content"][index]["type"] == QuestionTypes.checkbox.value
                              || form["content"][index]["type"] == QuestionTypes.dropdown.value
                              )
                            ...[
                              const SizedBox(height: 10),
                              ListView.builder(
                                itemCount: form["content"][index]["options"].length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index2) {

                                  return Row(
                                    children: [
                                      if(form["content"][index]["type"] == QuestionTypes.multipleChoice.value)
                                        const Radio(
                                          value: null,
                                          groupValue: null,
                                          onChanged: null,
                                        ),
                                      if(form["content"][index]["type"] == QuestionTypes.checkbox.value)
                                        const Checkbox(
                                          value: false,
                                          onChanged: null,
                                        ),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            border: UnderlineInputBorder(),
                                          ),
                                          onChanged: (v) => setState(() => form["content"][index]["options"][index2] = v),
                                          controller: optionControllers[index][index2],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () { 
                                          setState(() => form["content"][index]["options"].removeAt(index2));
                                          optionControllers[index].removeAt(index2);
                                        }
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() => form["content"][index]["options"].add(""));
                                        optionControllers[index].add(TextEditingController());
                                      },
                                      child: const Text("Add Option"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            Row(
                              children: [
                                const Text("Duplicate: "),
                                Card(
                                  child: TextButton(
                                    onPressed: () => setState(() {


                                      // List<Map<String, Object>> new_content=List.from(form["content"].toList());
                                      Map<String, Object> new_value={};
                                      List<String> options =[];
                                      new_value['type']=form["content"][index]["type"];
                                      new_value["title"]= form["content"][index]["title"] ;
                                      var l = form["content"][index]["options"].length - 1;
                                      for (var i = 0; i <= l; i++) {
                                        options.add(form["content"][index]["options"][i]);
                                      }
                                      new_value["options"]=options;
                                      form["content"].add(new_value);
                                      //form["content"].add(new_content[index]);

                                       optionControllers.add([
                                         TextEditingController(text: form["content"][index+1]["options"][0]),]);
                                       for (var i = 1; i <= l; i++) {
                                         optionControllers[form["content"].length - 1].add(
                                           TextEditingController(text: form["content"][index]["options"][i]),
                                         );
                                       }


                                      }),
                                    child: const Text('Duplicate Question'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    );
                  },
                ),
                const SizedBox(height: 10),



                Card(
                  child: TextButton(
                    onPressed: () => setState(() {
                      form["content"].add({
                        "type": QuestionTypes.singleLine.value,
                        "title": "Untitled Question",
                        "options": [
                          "Option 1",
                        ],
                      });
                      optionControllers.add([
                        TextEditingController(text: "Option 1"),
                      ]);
                    }),
                    child: const Text('Add Question'),
                  ),
                ),              
              ],  
              
              Text("Is open: ${context.watch<NearbyService>().isAdvertising}"),
              // Text(const JsonEncoder.withIndent("  ").convert(form)),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      NearbyService().stopAdvertising();
                      // developer.log(QuestionTypes.dropdown.value);

                      // developer.log(const JsonEncoder.withIndent("  ").convert(form)

                      developer.log(const JsonEncoder.withIndent("  ").convert(form));


                    },
                    child: const Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {

                      String s=Provider.of<NearbyService>(context, listen: false).userName.toString();
                      form['username']=s;
                      NearbyService().startAdvertising(isSharing ? shareMsg : form, isSharing: isSharing);
                      print(form);
                     // print(s);
                     // print(form);
                    },
                    child: const Text('Open'),
                  ),
                ],
              ),
              const Text("Responses"),
              // Text(const JsonEncoder.withIndent(" ").convert(payloads)),
              ListView.builder(
                itemCount: payloads.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, responseIndex) {
                  
                  if (payloads[responseIndex].isEmpty) return Container();
                  return ExpansionTile(
                    // title: Text(payloads[responseIndex]["name"]),
                    title: Text(payloads[responseIndex]["device_id"]),
                    children: [
                      Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("${payloads[responseIndex]["device_id"]}")
                          ),
                          ListView.builder(
                            itemCount: payloads[responseIndex]["content"].length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, questionIndex) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(payloads[responseIndex]['content'][questionIndex]["title"]),
                                  if(payloads[responseIndex]['content'][questionIndex]["type"] == QuestionTypes.singleLine.value
                                    || payloads[responseIndex]['content'][questionIndex]["type"] == QuestionTypes.multiLine.value)
                                    ...[
                                      Text(payloads[responseIndex]['content'][questionIndex]["response"]),
                                    ]
                                  else if(payloads[responseIndex]['content'][questionIndex]['type'] == QuestionTypes.multipleChoice.value
                                    || payloads[responseIndex]['content'][questionIndex]['type'] == QuestionTypes.checkbox.value)
                                    ...[
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: payloads[responseIndex]['content'][questionIndex]['options'].length,
                                        itemBuilder: (context, optionIndex) {
                                          return Row(
                                            children: [
                                              if(payloads[responseIndex]['content'][questionIndex]['type'] == QuestionTypes.multipleChoice.value)
                                                Radio(
                                                  value: optionIndex,
                                                  groupValue: payloads[responseIndex]['content'][questionIndex]['selected'],
                                                  onChanged: null,
                                                )
                                              else
                                                Checkbox(
                                                  value: payloads[responseIndex]['content'][questionIndex]['checked'].contains(optionIndex),
                                                  onChanged: null,
                                                ),
                                              Text(payloads[responseIndex]['content'][questionIndex]['options'][optionIndex]),
                                            ],
                                          );
                                        },
                                      )
                                    ]
                                  else if(payloads[responseIndex]['content'][questionIndex]['type'] == QuestionTypes.dropdown.value)
                                    ...[
                                      DropdownButton(
                                        value: payloads[responseIndex]['content'][questionIndex]['selected'],
                                        items: payloads[responseIndex]['content'][questionIndex]['options'].map<DropdownMenuItem<int>>(
                                          (e) => DropdownMenuItem<int>(
                                            value: payloads[responseIndex]['content'][questionIndex]['options'].indexOf(e),
                                            child: Text(e),
                                          ),
                                        ).toList() ,
                                        onChanged: null,
                                      )
                                    ],
                                  
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ]
                  );
                },
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     // developer.log(jsonEncode(form).runtimeType.toString());
              //     // developer.log(jsonDecode('{"type":"form","fields":[{"id":1,"title":"What is your name?"},{"id":2,"title":"What is your age?"}]}').runtimeType.toString());
              //     developer.log(context.read<NearbyService>().payloads.toString());
              //   },
              //   child: const Text('Test'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

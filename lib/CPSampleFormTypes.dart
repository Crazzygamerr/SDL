import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class CPSampleFormTypes extends StatefulWidget {
  const CPSampleFormTypes({Key? key}) : super(key: key);

  @override
  CPSampleFormTypesState createState() => CPSampleFormTypesState();
}

class CPSampleFormTypesState extends State<CPSampleFormTypes> {
  @override
  void initState() {
    // void activate() {
    super.initState();
    super.activate();
    // developer.log("init");
    // startDis();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<NearbyService>().payloads = [{}];
    // });
  }

  // void startDis() async {
  //   await NearbyService().stopAllEndpoints();
  //   String s = await NearbyService().startDiscovery();
  //   if(s != 'true') {
  //     showSnackbar(s);
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // context.read<NearbyService>().addListener(changeRoute);

  // }

  // void changeRoute() {
  //   if(context.read<NearbyService>().payloads[0].containsKey('content')
  //     && context.read<NearbyService>().isDiscovering
  //     && ModalRoute.of(context)!.settings.name != '/responsePage'
  //     ){
  //       Navigator.pushNamed(context, '/responsePage');
  //     }
  // }

  @override
  void dispose() {
    // // void deactivate() {
    //   NearbyService().stopDiscovery();
    //   NearbyService().stopAllEndpoints();
    // developer.log("dispose");
    // context.read<NearbyService>().removeListener(changeRoute);
    super.dispose();
    // super.deactivate();
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Color(0XFF50C2C9),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 246, 246),
        body: SafeArea(
            child: Column(children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Stack(children: [
                    // Positioned(
                    //   top: 640,
                    //   child: Container(
                    //       margin: EdgeInsets.all(25),
                    //       child: SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.88,
                    //         height: 60.0,
                    //         child: ElevatedButton(
                    //           style: flatButtonStyle,
                    //           onPressed: () {
                    //             Navigator.pushNamed(context, '/createForm');
                    //           },
                    //           child: Text(
                    //             "CREATE ROOM",
                    //             style: TextStyle(
                    //               fontFamily: 'Poppins',
                    //               fontSize: 15.0,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    // ),
                    // Positioned(
                    //   top: 560,
                    //   child: Container(
                    //       margin: EdgeInsets.all(25),
                    //       child: SizedBox(
                    //         width: MediaQuery.of(context).size.width * 0.88,
                    //         height: 60.0,
                    //         child: ElevatedButton(
                    //           style: flatButtonStyle,
                    //           onPressed: () {
                    //             Navigator.pushNamed(context, '/rooms');
                    //           },
                    //           child: Text(
                    //             "JOIN ROOM",
                    //             style: TextStyle(
                    //               fontFamily: 'Poppins',
                    //               fontSize: 15.0,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //       )),
                    // ),
                    // Positioned(
                    //     top: 510,
                    //     left: 145,
                    //     child: Container(
                    //       child: Text(
                    //         'Go Ahead',
                    //         style: TextStyle(
                    //           fontFamily: 'Poppins',
                    //           fontSize: 17.0,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //     )),
                    // Positioned(
                    //     top: 350,
                    //     left: 124,
                    //     child: Image(image: AssetImage('assets/welcomeScreenImg.png'))),
                    // Positioned(
                    //     top: 250,
                    //     left: 117,
                    //     child: Container(
                    //       child: Text(
                    //         'Welcome',
                    //         style: TextStyle(
                    //           fontFamily: 'Poppins',
                    //           fontSize: 28.0,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     )),

                    Positioned(
                        top: -10,
                        left: -110,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0x738FE1D7)),
                        )),
                    Positioned(
                        top: -110,
                        left: 0,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0x738FE1D7)),
                        )),
                  ])),

                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(left:40),
                  child: Image.asset('assets/formtypes2.jpeg',
                    height: 100,
                    width: 150,
                  ),

                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.only( left:200,bottom:10),
                  child: Image.asset('assets/Formtypes1.jpeg',
                    height: 100,
                    width: 150,
                  ),
                ),

              Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(top: 5, right: 25, left: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: 60.0,
                    child: ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Navigator.pushNamed(context, '/sampleCreateForm');
                      },
                      child: Text(
                        "EXISTING FORM",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(top: 8, right: 25, left: 25),

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: 60.0,
                    child: ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Navigator.pushNamed(context, '/sampleCreateForm');
                      },
                      child: Text(
                        "NEW FORM",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 2),
                  margin: EdgeInsets.only(top: 8, right: 25, left: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: 60.0,
                    child: ElevatedButton(
                      style: flatButtonStyle,
                      onPressed: () {
                        Navigator.pushNamed(context, '/sampleCreateForm');
                      },
                      child: Text(
                        "ATTENDANCE",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
            ])
          // appBar: AppBar(
          //   title: const Text('Sample'),
          // ),

          // body: SafeArea(
          //   child: Center(
          //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //       Align(
          //         widthFactor: 0.3,
          //         child: CircleAvatar(
          //           backgroundColor: Colors.blueAccent,
          //           radius: 70.0,
          //         ),
          //       ),
          //       Text(
          //         'Welcome',
          //         style: TextStyle(
          //           fontFamily: 'Poppins.SemiBold',
          //           fontSize: 30.0,
          //           color: Colors.teal,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ]),
          //   ),
          // ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
// import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ////////////////// CHECK CONNECTIVITY CONTINUOUSLY ///////////////////////
  // Define Variables
  StreamSubscription connectivitySubscription;
  ConnectivityResult previousresult;
  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult nowresult) {
      if (nowresult == ConnectivityResult.none) {
        // print('Not Connected');
        //TODO Flutter Toaster for None
        Fluttertoast.showToast(
          msg: "Network Connection Error",
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      // when mobile and wifi network connected
      else if (previousresult == ConnectivityResult.none) {
        // print('Connected');
        if (nowresult == ConnectivityResult.mobile) {
          // print('Mobile Network Connected');
          //TODO Flutter Toaster for Mobile
          Fluttertoast.showToast(
            msg: "Mobile Network Connected",
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (nowresult == ConnectivityResult.wifi) {
          // print('WiFi Network Connected');
          //TODO Flutter Toaster for WiFi
          Fluttertoast.showToast(
            msg: "WiFi Network Connected",
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
      previousresult = nowresult;
    });
  }

  // we need to dispose this to avoid running continuously
  // when we navigate towards new screen
  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connectivity Status',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            // Raised Button
            // Padding(
            //   padding: EdgeInsets.only(top: 50.0),
            //   child: RaisedButton(
            //     // onPressed: checkconnection,
            //     onPressed: () {},
            //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            //     child: Text(
            //       'Check',
            //       style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////
///////////////// CHECK CONNECTIVITY USING SOCKET METHOD ////////////////////
/////////////////////////////////////////////////////////////////////////////
// // here we lookup a website to get data
// // when we receive data, it means internet is connected
// void checkconnection() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     // result is in array form
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       print('Connected');
//     }
//   }
//   // if data not receive then we get an exception
//   on SocketException catch (_) {
//     print('Not Connected');
//   }
// }
//////////////////////////////////////////////////////////////////////////////
/////// CHECK CONNECTIVITY USING PACKAGE (Not Continuously) /////////////////
//////////////////////////////////////////////////////////////////////////////
// void checkconnection() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   // connected to a none network.
//   if (connectivityResult == ConnectivityResult.none) {
//     print('No Connection');
//   }
//   // connected to a mobile network.
//   else if (connectivityResult == ConnectivityResult.mobile) {
//     print('Mobile Network');
//   }
//   // connected to a wifi network.
//   else if (connectivityResult == ConnectivityResult.wifi) {
//     print('WiFi Network');
//   }
// }

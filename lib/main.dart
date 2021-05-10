import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_flutter/Screens/NetworkScreen.dart';
import 'package:weather_flutter/Screens/SplashScreen.dart';
import 'package:weather_flutter/services/locator.dart';
import 'file:///D:/flutter/weather_flutter/lib/Screens/Home.dart';

void main()
{
   setupLocator();
  runApp(myApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent));


}
class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  bool value=false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
          )),


      home: value?SplashScreen():NetWorkScreen(),
    );
  }

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  void checkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        changeValue(true);
      } else {
        changeValue(false);
      }
    });

  }

  void changeValue(bool ch) {
    setState(() {
      value=ch;
    });
  }


}




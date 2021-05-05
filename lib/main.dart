import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Home(),
    );
  }
}




import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_flutter/Screens/Home.dart';
import 'package:weather_flutter/main.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Container(
      decoration: BoxDecoration(
      image: new DecorationImage(
      image: new AssetImage("assets/splash.jpg"),
      fit: BoxFit.cover
      )
      ),
      ),
          Center(
            child: Container(
              width: double.infinity,
              height: 100,
              child: Column(
                children: [
              Text("Weather Climate",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 35,fontFamily: 'Paci')),
                  Text("weather forecast for countries",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 15,fontFamily: 'Paci')),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>Home()));
    });
  }
}

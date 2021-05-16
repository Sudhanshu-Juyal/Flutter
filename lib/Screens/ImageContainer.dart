import 'package:flutter/material.dart';
class ImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/wee.jpg"),
              fit: BoxFit.cover
          )
      ),
    );
  }
}

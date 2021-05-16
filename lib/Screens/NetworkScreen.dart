import 'package:flutter/material.dart';
class NetWorkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.5),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset("assets/error.jpg",height: 200.0,width: 100.0,)),
            Center(
                child: Text("Oops!!!",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  fontFamily: 'Paci',
                  fontSize: 35,),
                  textAlign: TextAlign.center,

                )),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 30),
              child: Center(
                child: Text("No Internet Connectivity,Please Check Your Setting",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                  fontFamily: 'Paci',
                  fontSize: 20,),
                  textAlign: TextAlign.center,
                ),

              ),
            ),
            // Expanded(
            //   child: Align(
            //     widthFactor: double.infinity,
            //     alignment: FractionalOffset.bottomCenter,
            //     child: Container(
            //       alignment:AlignmentDirectional.bottomCenter,
            //       color: Colors.black,
            //       width: MediaQuery.of(context).size.width,
            //       height: 50,
            //       child: Center(child: Text("Check Setting",style: TextStyle(color: Colors.white),)),
            //     ),
            //   ),
            // )

          ],

        ),
      ),

    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'file:///D:/flutter/weather_flutter/lib/Screens/Home.dart';
import 'package:sizer/sizer.dart';
class WeatherContainer extends StatefulWidget {
  WeatherModel data;
  BuildContext context;
  Icon customIcon;
  AsyncSnapshot<WeatherModel> snapshot;
  WeatherContainer(this.data, this.context, this.customIcon, this.snapshot);

  @override
  _WeatherContainerState createState() => _WeatherContainerState(data,context,customIcon,snapshot);
}

class _WeatherContainerState extends State<WeatherContainer>
{
  WeatherModel data;
  BuildContext context;
  Icon customIcon;
  AsyncSnapshot<WeatherModel> snapshot;
  _WeatherContainerState(this.data, this.context, this.customIcon, this.snapshot);
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.3,top:110 ),
        height: 200,
        child: Stack(
          children:
          [
            Positioned(
              top: -6,
              left: 25,
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.body1,
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.cloud_queue,color: Colors.white,),
                    ),

                    TextSpan(text: " "+data.weather[0].main,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                        fontFamily: 'Paci',

                        fontSize: 25)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
                child: Text("11°",style: TextStyle(color: Colors.white,fontSize: 105,fontWeight: FontWeight.w900,letterSpacing: 2,fontFamily: 'Paci'),textAlign: TextAlign.center,)),
            Positioned(
                top: 130,
                left: 20,

                child: Text(data.name
                  ,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),))
          ],
        ),
      ),
    );
  }
}
// Home.roundUpAbsolute(data.main.temp-272)
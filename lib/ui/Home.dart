import 'package:flutter/material.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/weather_model.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    weatherBloc.fetchWeather("CANADA");
    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
          if (snapshot.hasData) {
            return _buildWeatherScreen(snapshot.data,context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });

  }
  Scaffold _buildWeatherScreen(WeatherModel data, BuildContext context)
  {
return Scaffold(
  body: Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/wee.jpg"),
                fit: BoxFit.cover
            )
        ),


      ),
      Positioned(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              tooltip: 'Share',
            ),


          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){},
          ),
        ),
      ),
      Positioned(
        left:MediaQuery.of(context).size.width/2.5,
        top: 110,
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.wb_sunny_outlined,color: Colors.white,),
                          ),
                        ),

                        TextSpan(text: data.weather[0].main,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                      ],
                    ),
                  )
              ),Container(
                child: Text(roundUpAbsolute(data.main.temp-272.5)+"°",style: TextStyle(color: Colors.white,fontSize: 70,fontWeight: FontWeight.bold,letterSpacing: 2),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(data.name.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: 450,
        left: 20,
        child: Container(
          child: Column(
            children: [
              Container(
                width: 420,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'This Week',style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),

                                  child: Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                                ),

                              ),

                            ],
                          ),
                        )
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(right: 40),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.add,),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),

                  ],),
              ),

            ],
          ),
        ),
      )

    ],
  ),
);
    // return Container(
    //   padding: const EdgeInsets.all(17.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //
    //       Text(data.main.temp.toString())
    //     ],
    //   ),
    // );
  }
  static String roundUpAbsolute(double number) {
    return number.isNegative ? number.floor().toString() : number.ceil().toString();
  }
}

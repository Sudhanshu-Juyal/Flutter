import 'package:flutter/material.dart';
import 'package:weather_flutter/ItemWidget.dart';
import 'package:weather_flutter/bloc/previously_viewed_bloc.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/repo/weather_repo.dart';
class Previous extends StatefulWidget {
  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {

  @override
  Widget build(BuildContext context) {
    PreviouslyViewedBloc previouslyViewedBloc = PreviouslyViewedBloc();
    WeatherBloc weatherBloc = WeatherBloc();
    List<WeatherModel> weat = WeatherBloc.prev;

    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        actions: [
           IconButton(icon: Icon(Icons.search,color: Colors.black,), onPressed: null),
          PopupMenuButton<String>(
            icon: Image.asset("assets/dots.png",color: Colors.black,),
            onSelected: handleClick,
            itemBuilder: (BuildContext context){
              return {'Logout','Settings'}.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),);
              })
                  .toList();
            }
            ,),

          // IconButton(icon: Icon(Icons.search,color: Colors.black,), onPressed: null)
        ],
         //title: Text("Previously Viewed",style: TextStyle(color: Colors.black),),
        //
      ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text("Previously Viewed",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Paci'),),
              Expanded(
                child: ListView.builder(

                    itemCount: WeatherBloc.prev.length,
                    itemBuilder: (context, index) {
                      return Card(
                       elevation: 4.5,

                        margin: EdgeInsets.all(20),
                        color: Theme
                            .of(context)
                            .cardColor,
                        //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(

                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],


                            ),
                            height: 240,
                            width: double.infinity,
                            child: Column(
                              children:
                              [
                                Container(
                                  child: Expanded(child:
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                            image: DecorationImage(
                                                image: AssetImage('assets/wee.jpg'),
                                                fit: BoxFit.cover),
                                            ),
                                        ),
                                      Positioned(
                                          top: 40,
                                          left: 20,
                                          child: Text(WeatherBloc.prev[index].main.temp.toString()+" °",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Paci'),)

                                      ),
                                      Positioned(
                                          top: 80,
                                          left: 20,
                                          child: Text(WeatherBloc.prev[index].name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Paci'),)
                                      ),



                                    ],

                                  )),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.fromLTRB(20, 0, 0, 40),
                                          child: Text("Humidity "+WeatherBloc.prev[index].main.humidity.toString()+" %",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Paci'),)),
                                      Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 20, 40),
                                          child: Text(WeatherBloc.prev[index].timezone.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Paci')))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )


                      );
                    }),
              ),
            ],
          ),
        ));
  }
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}



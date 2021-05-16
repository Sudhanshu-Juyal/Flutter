import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Screens/CustomDataa.dart';
import 'package:weather_flutter/Screens/NetworkScreen.dart';
import 'package:weather_flutter/model/weather_model.dart';

import 'Home.dart';
import 'ImageContainer.dart';
import 'PreviouslyViewed.dart';
import 'WeatherContainer.dart';
class CurrentWeather extends StatefulWidget {
  WeatherModel data;
  BuildContext context;
  Icon customIcon;
  AsyncSnapshot<WeatherModel> snapshot;
  bool show=false;
  int selectedItemIndex;
  CurrentWeather(this.data, this.context, this.customIcon, this.snapshot, this.selectedItemIndex);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState(this.data, this.context, this.customIcon, this.snapshot, this.selectedItemIndex);
}

class _CurrentWeatherState extends State<CurrentWeather>
{
  Widget customSearchBar=Text("");
  final city=TextEditingController();
  WeatherModel data;
  bool show=false;
  BuildContext context;
  Icon customIcon;
  AsyncSnapshot<WeatherModel> snapshot;
  int selectedItemIndex;
  _CurrentWeatherState(this.data, this.context, this.customIcon, this.snapshot, this.selectedItemIndex);
  bool value=true;
  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: () async =>value? true:false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[

           ImageContainer(),
            Positioned(
              child: AppBar(
                title: customSearchBar,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: customIcon,
                    onPressed: () {
                      print("tapped");
                      setState(()
                      {
                        if(this.customIcon.icon==Icons.search)
                          {
                            show=true;
                              this.customIcon=Icon(Icons.cancel);
                              this.customSearchBar=TextField(

                                onSubmitted: (value)
                                {
                                  print("search");
                                },
                              controller: city,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search"
                              ),
                              textInputAction:TextInputAction.search,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,

                              ),
                            );
                          }
                        else
                          {
                            show=false;
                            print("tapping else");
                            this.customIcon=Icon(Icons.search);
                         // weatherBloc.previousResult(cityText,databaseHelper);
                         this.customSearchBar=Text("");
                          }
                      });
                    },
                    tooltip: 'Share',
                  ),


                  PopupMenuButton<String>(
                    icon: Image.asset("assets/dots.png",color: Colors.white,),
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context){
                      return {'Previously viewed','Item2'}.map((String choice){
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),);
                      })
                          .toList();
                    }
                    ,),



                ],
                leading: IconButton(
                  icon: Icon(


                    Icons.arrow_back,color: Colors.white,),
                  onPressed: (){

                    print("back pressed");

                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,height: MediaQuery.of(context).size.height*0.29,
              margin: EdgeInsets.only(top: 80),
              child: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.rtl,
                fit: StackFit.loose,
                overflow: Overflow.visible,
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    top:0,
                    left: MediaQuery.of(context).size.width*0.35,
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.body1,
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.cloud_queue,color: Colors.white,),
                          ),
                          TextSpan(text: " "+data.weather[0].main,style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.1,
                              fontFamily: 'Paci',

                              fontSize: 25)),
                        ],
                      ),
                    ),
                  ),
                   Positioned(
                     top: 8,
                      left: MediaQuery.of(context).size.width*0.29,
                     child: Container(

                         child: Text("23°",style: TextStyle(color: Colors.white,fontSize: 105,fontWeight: FontWeight.w900,letterSpacing: 2,fontFamily: 'Paci'),)),
                   ),
                   Positioned(
                       top: 130,
                       left: MediaQuery.of(context).size.width*0.35,
                       child: Text(data.name,style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w900),))

                ],
              )
            ),



            Positioned(
              child: CustomDataa()
            )

          ],
        )

      ),
    );
  }

  @override
  void initState() {
    chechStatus();
   super.initState();
  }
  void chechStatus() {
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

  void handleClick(String value) {
    switch (value) {
      case 'Previously viewed':
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => Previous(databaseHelper)));
        break;
      case 'Item 2':
        break;
    }
  }
}


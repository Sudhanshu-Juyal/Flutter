import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/Screens/NetworkScreen.dart';
import 'package:weather_flutter/bloc/PreviouslyViewedBloc.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/services/locator.dart';
import 'package:weather_flutter/utils/database_helper.dart';

import 'Home.dart';
class Previous extends StatefulWidget
{


  @override
  _PreviousState createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  var helper=locator<DatabaseHelper>();
  bool value=true;
  //_PreviousState(this.helper);
  PreviouslyBloc prevBloc;


  @override
  Widget build(BuildContext context)
  {
    return value?StreamBuilder(
        stream: prevBloc.allWeatherStream,
        builder: (context, AsyncSnapshot<List<PreviouslyViewd>> snapshot)
    {
        if(snapshot.hasData)
          {
         return   _buildWeatherScreen(snapshot.data,context);
          }
        else if(snapshot.hasError){
         return Container(
              width: 0.0,
              height: 0.0,
              child: Text('No Previous Data'));
        }
        return Container(child: Text(""),);
    }

        ):NetWorkScreen();

  }

  @override
  void initState() {
     prevBloc=PreviouslyBloc();
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

  Scaffold _buildWeatherScreen(List<PreviouslyViewd> data, BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: AppBar(
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

            ],
          ),
        ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Text("Previously Viewed",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Paci',fontWeight: FontWeight.w700),),
                Expanded(
                  child: ListView.builder(

                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                         elevation: 4.5,

                          margin: EdgeInsets.fromLTRB(30, 15, 30, 5),
                          color: Theme
                              .of(context)
                              .cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
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
                              height: 270,
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
                                          height: 180.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                              image: DecorationImage(
                                                  image: AssetImage('assets/wee.jpg'),
                                                  fit: BoxFit.cover),
                                              ),
                                          ),
                                        Positioned(
                                            top: 40,
                                            left: 15,
                                            child: Text(data[index].temp+"°",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 55,fontFamily: 'Paci'),)

                                        ),
                                        Positioned(
                                            top: 104,
                                            left: 16,
                                            child: Text(data[index].name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 30,fontFamily: 'Paci'),)
                                        ),



                                      ],

                                    )),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
                                            child: Text("Humidity: "+data[index].humidity+"%",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontFamily: 'Paci',fontSize: 18),)),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 50, 30),
                                            child: Text(data[index].timezone.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontFamily: 'Paci',fontSize: 20)))
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






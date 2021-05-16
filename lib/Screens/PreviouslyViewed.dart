import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
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
    return StreamBuilder(
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

        );

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
        backgroundColor: Colors.white,
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

            child: Column(
              children: [

                Text("Previously viewed",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'Paci',fontWeight: FontWeight.w900),),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    decoration: BoxDecoration(
                      color: Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(25.0)

                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context,index){
                          return Card(
                            elevation: 4.5,
                            margin: EdgeInsets.fromLTRB(8, 15, 8, 20),
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Container(
                              decoration: BoxDecoration(

                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 20.0,
                                  ),
                                ],


                              ),
                              height:  MediaQuery.of(context).size.height*0.32,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height*0.22,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          image: DecorationImage(
                                              image: AssetImage('assets/wee.jpg'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        height:  MediaQuery.of(context).size.height*0.2,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            Container(

                                              width: double.infinity,
                                              child: Text(data[index].temp+"°",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 55,fontFamily: 'Paci'),
                                                textAlign: TextAlign.start,),
                                            ),
                                            Container(

                                              width: double.infinity,
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(data[index].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 30,fontFamily: 'Paci'),
                                                  textAlign: TextAlign.start
                                                  ,),
                                            ),

                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.fromLTRB(30, 0, 0, 30),
                                            child: Text("Humidity: "+data[index].humidity+"%",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontFamily: 'Paci',fontSize: 18),)),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 30, 30),
                                            child: Text("13/28°",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontFamily: 'Paci',fontSize: 20)))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                          );
                        }),
                  ),
                )
              ],
            ),
          ),
      );
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






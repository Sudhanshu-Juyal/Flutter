import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_flutter/Screens/NetworkScreen.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/services/locator.dart';
import 'package:weather_flutter/utils/database_helper.dart';

import 'ImageContainer.dart';
class SearchWeather extends StatefulWidget {
  @override
  _SearchWeatherState createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather>
{
  bool value=true;
  TextEditingController searchText=TextEditingController();
  // DatabaseHelper databaseHelper = DatabaseHelper();
  var databaseHelper=locator<DatabaseHelper>();
  List<PreviouslyViewd> previousList;
  @override
  Widget build(BuildContext context) {
    if (previousList == null) {
      previousList = List<PreviouslyViewd>();
      init();
    }
    return value?Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ImageContainer(),
          Positioned(
            child: Center(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        height: 50,
                        child: TextField(
                          cursorColor: Colors.white,
                         style: TextStyle(color: Colors.white),
                          controller: searchText,
                          onChanged: (value)
                             {
                           debugPrint("Search text"+searchText.text);
//  weatherBloc.previousResult(searchText.text);
                          },
                                decoration: InputDecoration(

                                  labelStyle:TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(fontSize: 15.0, color:Colors.white),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                labelText: 'Enter Country Name',
                                hintText: 'ex:Canada',
                                border: OutlineInputBorder(
                                borderSide: BorderSide(
                                color: Colors.white, width: 19.0),
                                borderRadius: BorderRadius.circular(5.0)

                                  ),
                                    )
                               ),
                      ),

                      ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 50,
                      child:     RaisedButton(
                        color:Colors.black,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          'Search',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Save button clicked"+searchText.text);
                        //    weatherBloc.previousResult(searchText.text,databaseHelper);
                            weatherBloc.previousResulWeather(searchText.text);

                          });
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )

        ],
      )
    ):NetWorkScreen();
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
  void init() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

  }
}


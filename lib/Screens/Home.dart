import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_flutter/Screens/CurrentWeather.dart';
import 'file:///D:/flutter/weather_flutter/lib/Screens/PreviouslyViewed.dart';
import 'package:weather_flutter/Screens/SearchWeather.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/utils/database_helper.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  static String roundUpAbsolute(double number) {
    return number.isNegative ? number.floor().toString() : number.ceil().toString();
  }
}

class _HomeState extends State<Home>
{
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PreviouslyViewd> previousList;
  TextEditingController searchText=TextEditingController();
  Widget customSearchBar=Text("");
  Icon customIcon=Icon(Icons.search);
  String cityText="";
  bool show=false;
  final city=TextEditingController();

  void setText()
  {
    setState(() {
   cityText=city.text;
   city.addListener(() {
     print("text is $cityText");
     weatherBloc.previousResult(cityText,databaseHelper);
   });
    });
  }
  int selectedItemIndex=0;
  int _currentIndex=0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context)
  {
    if (previousList == null) {
      previousList = List<PreviouslyViewd>();
      init();
    }

    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
          if (snapshot.hasData) {
            return _buildWeatherScreen(snapshot.data,context,customIcon,snapshot,selectedItemIndex);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return SearchWeather();
        });

  }

  Scaffold _buildWeatherScreen(WeatherModel data, BuildContext context, Icon customIcon, AsyncSnapshot<WeatherModel> snapshot, int selectedItemIndex)
  {
    final _tabs=[CurrentWeather(data,context,customIcon,snapshot,selectedItemIndex),Previous(databaseHelper)];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.add, size: 30,color: Color(0xff7340bf),),
          Icon(Icons.list, size: 30,color: Color(0xff7340bf),),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body:_tabs[_page]

    );

  }

  void handleClick(String value) {
    switch (value) {
      case 'Previously viewed':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Previous(databaseHelper)));
        break;
      case 'Item 2':
        break;
    }
  }



  void init() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

  }


}

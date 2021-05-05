import 'package:flutter/material.dart';
import 'file:///D:/flutter/weather_flutter/lib/Screens/PreviouslyViewed.dart';
import 'package:weather_flutter/Screens/CustomData.dart';
import 'package:weather_flutter/Screens/ImageContainer.dart';
import 'package:weather_flutter/Screens/WeatherContainer.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/weather_model.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  static String roundUpAbsolute(double number) {
    return number.isNegative ? number.floor().toString() : number.ceil().toString();
  }
}

class _HomeState extends State<Home>
{
  Widget customSearchBar=Text("");
  Icon customIcon=Icon(Icons.search);
  String cityText="";
  final city=TextEditingController();

  void setText()
  {
    setState(() {
   cityText=city.text;
   city.addListener(() {
     print("text is $cityText");
     weatherBloc.previousResult(cityText);
   });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
          if (snapshot.hasData) {
            return _buildWeatherScreen(snapshot.data,context,customIcon,snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Center(child: CircularProgressIndicator());
        });

  }

  Scaffold _buildWeatherScreen(WeatherModel data, BuildContext context, Icon customIcon, AsyncSnapshot<WeatherModel> snapshot)
  {
return Scaffold(
  resizeToAvoidBottomInset: false,
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
                      print("tapping else");
                      this.customIcon=Icon(Icons.search);
                   weatherBloc.previousResult(cityText);
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
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){

              print("back pressed");

            },
          ),
        ),
      ),
      Positioned(
        left:MediaQuery.of(context).size.width/2.8,
        top: 110,
        child: WeatherContainer(data,context,customIcon,snapshot)
      ),
      Positioned(
        child: CustomData(),
      )

    ],
  ),
);

  }
  void handleClick(String value) {
    switch (value) {
      case 'Previously viewed':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Previous()));
        break;
      case 'Item 2':
        break;
    }
  }

  @override
  void initState() {
  //  weatherBloc.fetchWeather("CANADA");
    weatherBloc.previousResult("CANADA");
  }
}

import 'package:flutter/material.dart';
import 'package:weather_flutter/PreviouslyViewed.dart';
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
  Widget customSearchBar=Text("GHH");
  Icon customIcon=Icon(Icons.search);
  String cityText="";
  List<String> datta=new List();
  List<String> degreeList=new List();


  final city=TextEditingController();

  void setText()
  {
    setState(() {
   cityText=city.text;
   city.addListener(() {
     print("text is $cityText");
     weatherBloc.fetchWeather(cityText);
   });
    });
  }
  @override
  Widget build(BuildContext context)
  {
     weatherBloc.fetchWeather("CANADA");
     datta.clear();
     datta.add("Today");
     datta.add("Monday");
     datta.add("Tuesday");
     datta.add("Wednesday");
     datta.add("Thursday");
     datta.add("Friday");
     degreeList.add("24°");
     degreeList.add("24°");
     degreeList.add("24°");
     degreeList.add("24°");
     degreeList.add("24°");
     degreeList.add("24°");
     degreeList.add("24°");
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
          title: customSearchBar,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: customIcon,
              onPressed: () {
                print("tapped");
                setState(() {
                  if(this.customIcon.icon==Icons.search)
                    {
                      print("tapping");
                        this.customIcon=Icon(Icons.cancel);
                        this.customSearchBar=TextField(
                        controller: city,

                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search"
                        ),
                        textInputAction:TextInputAction.go,
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
                   weatherBloc.fetchWeather("india");
                   this.customSearchBar=Text("");
                    }
                });
              },
              tooltip: 'Share',
            ),



          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){

            },
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
                child: Text(Home.roundUpAbsolute(data.main.temp-272.5)+"°",style: TextStyle(color: Colors.white,fontSize: 70,fontWeight: FontWeight.bold,letterSpacing: 2),),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(data.name.toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Positioned(

          child: Container(
            child: Column(
              children: [
                Container(
                  width: 420,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Tapped a Container");
                      //    weatherBloc.fetchWeather("india");
                         // weatherBloc.previousResult("india");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Previous()));


                        },
                        child: Container(

                            margin: EdgeInsets.fromLTRB(20, 400, 10, 0),
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
                      ),

  ],
  ),
  ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  height: 500,
                  child: ListView.builder(itemCount:datta.length ,
                            itemBuilder: (BuildContext context,int index)
                    {
                      return ListTile(
                          leading: Text(datta[index],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          //trailing: IconButton(icon:Icon(Icons.wb_sunny_outlined,color: Colors.white,),),
                          trailing:Text(degreeList[index],style: TextStyle(color: Colors.white),),);

                    },

                  ),
                )

              ],
            ),
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


}

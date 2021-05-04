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
  Widget customSearchBar=Text("");
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
     weatherBloc.previousResult(cityText);
   });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    weatherBloc.previousResult("CANADA");
     datta.clear();
     datta.add("Today");
     datta.add("Monday");
     datta.add("Tuesday");
     datta.add("Wednesday");
     datta.add("Thursday");
     datta.add("Friday");
     degreeList.add("24° ");
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
  resizeToAvoidBottomInset: false,
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
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.wb_sunny_outlined,color: Colors.white,),
                        ),

                        TextSpan(text: data.weather[0].main,style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Paci',
                            fontSize: 20)),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 1,),
              Container(
                child: Text(Home.roundUpAbsolute(data.main.temp-272.5)+"°",style: TextStyle(color: Colors.white,fontSize: 80,fontWeight: FontWeight.bold,letterSpacing: 2,fontFamily: 'Paci'),),
              ),
              SizedBox(height: 1,),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text(data.name.toString(),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
      Positioned(

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
                       //  Navigator.push(context, MaterialPageRoute(builder: (context) => Previous()));


                      },
                      child: Container(

                          margin: EdgeInsets.fromLTRB(28, 415, 10, 0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'This Week',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Paci',
                                    fontSize: 18)),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),

                                    child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                  ),

                                ),


                              ],
                            ),
                          )
                      ),
                    ),
                     Container(
                      decoration: BoxDecoration(
                      color: Colors.transparent,
                       borderRadius: BorderRadius.all(
                      Radius.circular(100),
                      ),
                     boxShadow: [
                       BoxShadow(
                     color: Colors.orangeAccent.withOpacity(0.9),
                     spreadRadius: 12,
                     blurRadius: 10,
                      offset: Offset(3, 5),
                     ),
                      ],),
                       margin: EdgeInsets.fromLTRB(20, 415, 10, 0),
                       child: FloatingActionButton(
                         elevation: 54.0,

                        child: Icon(Icons.add,size: 40,color: Colors.white,),
                        backgroundColor: Colors.orangeAccent,
                        onPressed: () {

                        },
                    ),
                     ),

  ],
  ),
  ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 28),
                  height: 500,
                  child: ListView.builder(itemCount:datta.length ,
                            itemBuilder: (BuildContext context,int index)
                    {
                      return Container(

                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                width:120,
                                  child: Text(datta[index],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Paci'))),
                              SizedBox(width: 130,),
                              Text(degreeList[index],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Paci')),
                              SizedBox(width: 0,),
                              IconButton(icon:Icon(Icons.wb_sunny_outlined,color: Colors.white,)),


                            ],
                          ),
                        ),
                      );
                      // return ListTile(
                      //     leading: Text(datta[index],style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Paci'),),
                      //     //trailing: IconButton(icon:Icon(Icons.wb_sunny_outlined,color: Colors.white,),),
                      //     trailing:Text(degreeList[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      // title: Text(degreeList[index]),



                    },

                  ),
                ),
              )

            ],
          ),
        ),
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

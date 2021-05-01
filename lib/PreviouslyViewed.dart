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

class _PreviousState extends State<Previous>
{

  @override
  Widget build(BuildContext context)
  {
    PreviouslyViewedBloc previouslyViewedBloc=PreviouslyViewedBloc();
    WeatherBloc weatherBloc=WeatherBloc();
   List<WeatherModel> weat= WeatherBloc.prev;

    return Scaffold(
    body:    ListView.builder(
        itemCount:  WeatherBloc.prev.length,
        itemBuilder: (context, index) {
      return ListTile(
        title: Text(weat[index].main.temp.toString()),
      );
    }));

    //   body: StreamBuilder(
    //     stream: previouslyViewedBloc.previouslyViewedStream,
    //       builder: (context, AsyncSnapshot<List<WeatherModel>> snapshot)
    // {
    //   if (snapshot.hasError) {
    //     return CircularProgressIndicator();
    //   } else if (snapshot.hasData) {

      }
    //   else {
    //     return CircularProgressIndicator();
    //   }
    // }
    // ));
  }



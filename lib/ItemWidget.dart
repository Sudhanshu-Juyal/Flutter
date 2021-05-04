import 'package:flutter/material.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';
class ItemWidget extends StatelessWidget
{

  List<WeatherModel> weatherModel;
  int index;


  ItemWidget(this.weatherModel, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(

        child: Container(
          height: 200,
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Stack(
                children: [
                  Text(weatherModel[index].main.temp.toString())
                ],
              )
            ],
          ),
        )

      ),
    );
  }
}

// class ItemWidget extends StatefulWidget
// {
//   @override
//   _ItemWidgetState createState() => _ItemWidgetState();
// }
//
// class _ItemWidgetState extends State<ItemWidget>
// {
//   List<PreviouslyViewd> list;
//
//   _ItemWidgetState(this.list);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Card(
//
//       ),
//
//     );
//   }
// }

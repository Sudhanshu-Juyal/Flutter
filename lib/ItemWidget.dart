import 'package:flutter/material.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
class ItemWidget extends StatelessWidget
{
  List<PreviouslyViewd> list;

  ItemWidget(this.list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(

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

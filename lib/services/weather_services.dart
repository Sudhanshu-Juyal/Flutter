import 'dart:convert';

import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/utils/database_helper.dart';

import 'locator.dart';
class WeatherServices
{

  Future<WeatherModel> getWeatherList(String city) async
  {
    final result=await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");
    if(result.statusCode!=200)
    {
      throw Exception();
    }
    return WeatherModel.fromJson(jsonDecode(result.body));
  }
  // Future<List<PreviouslyViewd>> getPreviousViewed() async
  // {
  //
  //   List<PreviouslyViewd> previousViewListFuture= await databaseHelper.getWeatherList();
  //   return previousViewListFuture;
  // }
  // void save(WeatherModel data) async
  // {
  //   PreviouslyViewd previouslyViewd=PreviouslyViewd(data.main.temp.toString(), data.name,data.timezone.toString(),data.main.humidity.toString());
  //   int result=await databaseHelper.inserWeather(previouslyViewd);
  //   if(result!=0)
  //   {
  //     print("data saved");
  //   }
  //   else{
  //     print("data not saved");
  //   }
  // }
}
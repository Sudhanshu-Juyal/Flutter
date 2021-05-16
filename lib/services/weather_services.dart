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
      throw Exception("Please enter valid city");
    }
    return WeatherModel.fromJson(jsonDecode(result.body));
  }

}
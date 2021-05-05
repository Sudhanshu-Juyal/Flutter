import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/services/locator.dart';
import 'package:weather_flutter/services/weather_services.dart';
class weatherRepo
{
  var weatherService=locator<WeatherServices>();
  Future<WeatherModel> getWeather(String city) async
  {
    WeatherModel weatherModel=await weatherService.getWeatherList(city);
    return weatherModel;
  }
}
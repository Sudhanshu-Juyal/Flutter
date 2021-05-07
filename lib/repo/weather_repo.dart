import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'dart:convert';

import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/services/locator.dart';
import 'package:weather_flutter/services/weather_services.dart';
import 'package:weather_flutter/utils/database_helper.dart';
class weatherRepo
{
  var weatherService=locator<WeatherServices>();
  Future<WeatherModel> getWeather(String city) async
  {
    WeatherModel weatherModel=await weatherService.getWeatherList(city);
    return weatherModel;
  }

  Future<List<PreviouslyViewd>> getPreviousViewed(DatabaseHelper helper) async
  {

    List<PreviouslyViewd> previousViewListFuture= await weatherService.getPreviousViewed(helper);
    return previousViewListFuture;
  }
  save(WeatherModel weatherModel,DatabaseHelper helper) async
  {
    weatherService.save(weatherModel,helper);
  }
}
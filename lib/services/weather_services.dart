import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/repo/weather_repo.dart';

class WeatherServices
{
  weatherRepo repo=weatherRepo();
  Future<WeatherModel> getWeatherList(String city) async
  {
    WeatherModel weatherModel=await repo.getWeather(city);
    return weatherModel;

  }
}
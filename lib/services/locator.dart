import 'package:get_it/get_it.dart';
import 'package:weather_flutter/services/weather_services.dart';

GetIt locator = GetIt.instance;

void setupLocator()
{
locator.registerSingleton(WeatherServices());
}
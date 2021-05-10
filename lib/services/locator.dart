import 'package:get_it/get_it.dart';
import 'package:weather_flutter/services/database_services.dart';
import 'package:weather_flutter/services/weather_services.dart';
import 'package:weather_flutter/utils/database_helper.dart';

GetIt locator = GetIt.instance;

void setupLocator()
{
locator.registerSingleton(WeatherServices());
locator.registerSingleton(DatabaseHelper());
locator.registerSingleton(DatabaseServices());
}
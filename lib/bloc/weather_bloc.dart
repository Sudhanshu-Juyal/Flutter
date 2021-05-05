import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/repo/weather_repo.dart';
import 'package:weather_flutter/services/locator.dart';
import 'package:weather_flutter/services/weather_services.dart';

class WeatherBloc
{
  weatherRepo repo=weatherRepo();
  static List<WeatherModel> prev=new List();
  final _list = BehaviorSubject<List<WeatherModel>>();
  Observable<List<WeatherModel>> get list => _list.stream;
  final _weatherFetcher=PublishSubject<WeatherModel>();
  Observable<WeatherModel> get weather=>_weatherFetcher.stream;

  List<WeatherModel> previouslySeenList;
  previousResult(String city) async
  {

    WeatherModel weatherModel=await repo.getWeather(city);
    _weatherFetcher.sink.add(weatherModel);
    prev.add(weatherModel);
    _list.sink.add(prev);
  }
}
final weatherBloc = WeatherBloc();
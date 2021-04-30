import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/repo/weather_repo.dart';

class WeatherBloc
{
  weatherRepo repo=weatherRepo();
  final List<WeatherModel> previouslyViewed=new List();
  final _weatherFetcher=PublishSubject<WeatherModel>();
  StreamController<WeatherModel> sController=StreamController<WeatherModel>();
  Sink<WeatherModel> get WeatherModelSink=>sController.sink;
  Stream<WeatherModel> get WeatherModelStream=>sController.stream;
  Observable<WeatherModel> get weather=>_weatherFetcher.stream;

  fetchWeather(String city) async
  {
    WeatherModel weatherModel=await repo.getWeather(city);
    _weatherFetcher.sink.add(weatherModel);
  }
  previousData()
  {
    sController.stream.listen(onWatched);
  }

  onWatched(WeatherModel pre)
  {
    this.previouslyViewed.add(pre);
  }
  dispose() {
    _weatherFetcher.close();
  }

}
final weatherBloc = WeatherBloc();
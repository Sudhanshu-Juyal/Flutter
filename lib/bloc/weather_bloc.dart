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
  final _list = BehaviorSubject<List<WeatherModel>>(); //private variable
  Observable<List<WeatherModel>> get list => _list.stream;
  final _weatherFetcher=PublishSubject<WeatherModel>();
  StreamController<List<WeatherModel>> sController=StreamController<List<WeatherModel>>();
  final _controller = StreamController<List<WeatherModel>>();
  Stream<List<WeatherModel>> get WeatherStream => _controller.stream;
  //Sink<List<WeatherModel>> get WeatherModelSink=>sController.sink;
  //Stream<List<WeatherModel>> get WeatherModelStream=>sController.stream;
  final _listWeatherFetcher=PublishSubject<List<WeatherModel>>();
  Observable<WeatherModel> get weather=>_weatherFetcher.stream;
  Observable<List<WeatherModel>> get weatherFetch=>_listWeatherFetcher.stream;

  void submitQuery(String query) async {
    // 1
    final results = prev;
    _controller.sink.add(results);
  }
  List<WeatherModel> previouslySeenList;
  fetchWeather(String city) async
  {
    WeatherModel weatherModel=await repo.getWeather(city);
    _weatherFetcher.sink.add(weatherModel);
    prev.add(weatherModel);
    _list.sink.add(prev);
  }
  previousResult(String city) async
  {
   // var userService = locator<UserService>();
    var weatherService=locator<WeatherServices>();
    WeatherModel weatherModel=await weatherService.getWeatherList(city);
    _weatherFetcher.sink.add(weatherModel);
    prev.add(weatherModel);
    _list.sink.add(prev);
  }


}
final weatherBloc = WeatherBloc();
import 'dart:async';

import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/repo/weather_repo.dart';
import 'package:weather_flutter/utils/database_helper.dart';

class PreviouslyBloc
{
 weatherRepo repo=weatherRepo();
 final _allWeatherViewedController=StreamController<List<PreviouslyViewd>>();
 Stream<List<PreviouslyViewd>> get allWeatherStream=>_allWeatherViewedController.stream;
 List<PreviouslyViewd> allWeathers;
 PreviouslyBloc()
 {
  showList();
 }
 showList() async
 {
  allWeathers= await repo.getPreviousViewed();
  _allWeatherViewedController.sink.add(allWeathers);
 }

 }




import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';
import 'package:weather_flutter/utils/database_helper.dart';

import 'locator.dart';

class DatabaseServices
{
  var databaseHelper=locator<DatabaseHelper>();

  Future<List<PreviouslyViewd>> getPreviousViewed() async
  {

    List<PreviouslyViewd> previousViewListFuture= await databaseHelper.getWeatherList();
    return previousViewListFuture;
  }
  void save(WeatherModel data) async
  {
    if (data != null) {
      PreviouslyViewd previouslyViewd = PreviouslyViewd(
          data.main.temp.toString(), data.name, data.timezone.toString(),
          data.main.humidity.toString());
      int result = await databaseHelper.inserWeather(previouslyViewd);
      if (result != 0) {
        print("data saved");
      }
      else {
        print("data not saved");
      }
    }
    else
      {
        print("data is null");
      }
  }
}
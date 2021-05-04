import 'package:rxdart/rxdart.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';
import 'package:weather_flutter/model/weather_model.dart';

class PreviouslyViewedBloc
{
final _previouslyViewedController=BehaviorSubject<List<WeatherModel>>();
Stream<List<WeatherModel>> get previouslyViewedStream=>_previouslyViewedController;
List<WeatherModel> listingData;
PreviouslyViewedBloc()
{
  WeatherBloc weatherBloc=WeatherBloc();
  listingData= WeatherBloc.prev;
  _previouslyViewedController.sink.add(listingData);
}
}
// final _postDetailController=BehaviorSubject<PostDetail>();
// Stream<PostDetail> get postDetailStream=>_postDetailController;
//
// PostDetail data;
// postDetail(int id) async{
//   data=await getPostDetail(id);
//   print(data.title);
//   _postDetailController.sink.add(data);
// }

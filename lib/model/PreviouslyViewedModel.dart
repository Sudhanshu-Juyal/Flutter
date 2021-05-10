import 'package:weather_flutter/model/weather_model.dart';

class PreviouslyViewd
{
int _id;
String _temp;
String _name;
String _timezone;
String _humidity;

 PreviouslyViewd(this._temp,this._name,this._timezone,this._humidity);
PreviouslyViewd.withName(this._id,this._temp,this._name,this._timezone,this._humidity);
String get temp=>_temp;
String get name=>_name;
String get timezone=>_timezone;
String get humidity=>_humidity;

set temp(String newTemp)
{
 this._temp=newTemp;
}
set name(String newName)
{
 this._name=newName;
}
set timezone(String newTimeZone)
{
 this._timezone=newTimeZone;
}
set humidity(String newHumidity)
{
 this._humidity=newHumidity;
}
      Map<String,dynamic> toMap()
      {
         var map=Map<String,dynamic>();
         map['temp']=_temp;
         map['name']=_name;
         map['timezone']=_timezone;
         map['humidity']=_humidity;
        return map;
      }
      PreviouslyViewd.fromMapObject(Map<String,dynamic> map)
         {
           this._id=map['id'];
        this._temp=map['temp'];
        this._name=map['name'];
        this._timezone=map['timezone'];
        this._humidity=map['humidity'];
}

}

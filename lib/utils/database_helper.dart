import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_flutter/Config/Data.dart';
import 'package:weather_flutter/model/PreviouslyViewedModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String weatherTable = 'weatherTablee';
  String colId = 'id';
  String colTemp = 'temp';
  String colName = 'name';
  String colTimeZone = 'timezone';
  String colHumidity = 'humidity';

  DatabaseHelper.createInstance();

  factory DatabaseHelper()
  {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async
  {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var notesDatabase = await openDatabase(
        path, version: 1, onCreate: _createDb);
    return notesDatabase;

  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $weatherTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTemp TEXT, '
            '$colName TEXT, $colHumidity TEXT, $colTimeZone TEXT)');
  }
  Future<int> inserWeather(PreviouslyViewd previouslyViewd) async {
    Database db = await this.database;
    var result = await db.insert(weatherTable, previouslyViewd.toMap());
    return result;
  }

  Future<List<PreviouslyViewd>> getWeatherList() async {

    var weatherMapList = await getWeatherMapList();
    int count = weatherMapList.length;

    List<PreviouslyViewd> noteList = List<PreviouslyViewd>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(PreviouslyViewd.fromMapObject(weatherMapList[i]));
    }

    return noteList;
  }
  Future<List<Map<String, dynamic>>> getWeatherMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $weatherTable ORDER BY ID DESC");
    return result;
  }


}
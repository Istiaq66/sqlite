
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite/models/scholar_model.dart';

class LocalRepo{

  var logger = Logger();
  Database? _database;
  List<Scholar>? scholars;

  static final LocalRepo instance = LocalRepo._constructor();

  LocalRepo._constructor(){
    logger.i("LocalRepo constructor created");
  }

  factory LocalRepo(){
    return instance;
  }


  Future<void> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "hadith.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      logger.i("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load("assets/hadith.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      logger.i("Opening existing database");
    }
    // open the database
    _database = await openDatabase(path, readOnly: true);
    logger.i("Database Created");
  }



  Future<List<Scholar>?> fetchData() async {
    Database? database = _database;
    if(scholars == null || scholars!.isEmpty){
      logger.e("scholars is Empty.");
      // Define the SQL query
      String tableName = "scholar"; // Replace with your table name
      String query = "SELECT * FROM $tableName"; // Adjust the query as needed

      // Execute the query and fetch the data
      List<Map<String, dynamic>> results = await database!.rawQuery(query);

      // Convert the database results to a list of Scholar objects
      scholars = results.map((row) {
        return Scholar(
          id: row['id'] as int,
          famousName: row['famous_name'] as String,
          bornOn: row['born_on'] as String? ?? '',
          diedOn: row['died_on'] as String? ?? '',
          livedIn: row['lived_in'] as String,
          nickName: row['nick_name'] as String? ?? '',
        );
      }).toList();
    }

    return scholars;
  }


  Future<void> listTables() async {
    try {
      if (_database == null) {
        logger.e("Database is not initialized.");
        return;
      }

      logger.i("Fetching table names...");
      List<Map<String, dynamic>> tables = await _database!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table'"
      );

      if (tables.isEmpty) {
        logger.e("No tables found in the database.");
      } else {
        for (var table in tables) {
          logger.i("Table: ${table['name']}");
        }
      }
    } catch (e) {
      logger.e("Error listing tables: $e");
    }
  }




}
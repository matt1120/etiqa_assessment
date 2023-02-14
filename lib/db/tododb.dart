import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoDB {
  static final TodoDB instance = TodoDB._init();

  static Database? _database;

  TodoDB._init();
  static const int databaseVersion = 1;

  static const String table = "todolist";
  static const String columnId = "id";
  static const String columnTodoTitle = "todo_title";
  static const String columnStartDate = "start_date";
  static const String columnEndDate = "end_date";
  static const String columnStatus = "status";

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todolist.db');
    return _database!;
  }

  //initialise database
  Future<Database> _initDB(String filePath) async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, filePath);

    return await openDatabase(path,
        version: databaseVersion, onCreate: _createDB);
  }

  // create database
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $table ( 
        $columnId $idType, 
        $columnTodoTitle $textType,
        $columnStartDate $textType,
        $columnEndDate $textType,
        $columnStatus $textType
        )
      ''');
  }

  //insert data into database
  Future<void> insertData(
      {required todoTitle, required startDate, required endDate}) async {
    final db = await instance.database;
    // await db.rawQuery("ALTER TABLE $table ADD $columnStatus TEXT NOT NULL;");
    await db.rawInsert(
        'INSERT INTO $table($columnTodoTitle, $columnStartDate, $columnEndDate, $columnStatus) VALUES("$todoTitle", "$startDate", "$endDate", "Incomplete")');
  }

  //read all the data from the database
  //query the data from descending in order to set the newest data on the top
  readData() async {
    final db = await instance.database;
    String sqlQuery = "SELECT * FROM $table ORDER BY $columnId DESC";
    var data = await db.rawQuery(sqlQuery);
    if (data.isNotEmpty) {
      var jsonEncodedData = jsonEncode(data);
      return jsonEncodedData;
    }
    return [];
  }

  //update data
  update(String title, String startDate, String endDate, int id) async {
    try {
      final db = await instance.database;
      String sqlQuery =
          'UPDATE $table SET $columnTodoTitle = "$title", $columnStartDate = "$startDate", $columnEndDate = "$endDate" WHERE $columnId = $id';
      await db.rawQuery(sqlQuery);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  //update status if completed
  updateStatus(String status, int id) async {
    try {
      final db = await instance.database;
      String sqlQuery =
          'UPDATE $table SET $columnStatus = "$status" WHERE $columnId = $id';
      await db.rawQuery(sqlQuery);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  //delete all the data from the database
  delete() async {
    final db = await instance.database;
    String sqlQuery = "DELETE from $table";
    await db.rawQuery(sqlQuery);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

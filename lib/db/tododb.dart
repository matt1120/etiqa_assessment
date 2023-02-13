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
        $columnEndDate $textType
        )
      ''');
  }

  Future<void> insertData(
      {required todoTitle, required startDate, required endDate}) async {
    final db = await instance.database;
    await db.rawInsert(
        'INSERT INTO $table($columnTodoTitle, $columnStartDate, $columnEndDate) VALUES("$todoTitle", "$startDate", "$endDate")');
  }

  readData() async {
    final db = await instance.database;
    String sqlQeury = "SELECT * FROM $table";
    var data = await db.rawQuery(sqlQeury);
    if (data.isNotEmpty) {
      return jsonEncode(data);
    }
    return [];
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

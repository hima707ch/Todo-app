import 'dart:io';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colPriorityValue = 'priorityValue';
  String colDate = 'dueDate';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // init directory
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tasks.db';

    var taskDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return taskDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority TEXT, $colPriorityValue INTEGER, $colDate TEXT)');
  }

  // get All
  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;

//	var result = await db.rawQuery('SELECT * FROM $taskTable order by $colPriority ASC');
    var result = await db.query(taskTable);
    return result;
  }

  // Insert one
  Future<int> insertTask(Task task) async {
    Database db = await this.database;
    var result = await db.insert(taskTable, task.toMap());
    return result;
  }

  // Update One
  Future<int> updateTask(Task task) async {
    var db = await this.database;
    var result = await db.update(taskTable, task.toMap(), where: '$colId = ?', whereArgs: [task]);
    return result;
  }

  // Delete One
  Future<int> deleteTask(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $taskTable WHERE $colId = $id');
    return result;
  }

  // get task list
  Future<List<Task>> getTaskList() async {

    var taskMapList = await getTaskMapList(); // Get 'Map List' from database
    int count = taskMapList.length;         // Count the number of map entries in db table

    List<Task> taskList = [];

    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMap(taskMapList[i]));
    }

    return taskList;
  }
}
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/database_helper.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> _tasks = [
    // Task(title: 'Buy milk',description: "Make Coffe", priority: "Avrage", dueDate: "25-Nov"),
    // Task(title: 'Buy eggs',description: "Make Coffe", priority: "Avrage", dueDate: "25-Nov"),
    // Task(title: 'Buy bread',description: "", priority: "", dueDate: ""),
  ];

  var userUid = null;

  var userData = null;

  DatabaseHelper _databaseHelper = DatabaseHelper();

  void setUid(uid){
    userUid = uid;
    fetchTasks();
    notifyListeners();
  }

  void getLocal() async {
    var temp2 = await _databaseHelper.getTaskList();
    print(temp2);

     _tasks = temp2;

     notifyListeners();

  }

  void fetchTasks() async{
    if(userUid != null) {
      print("in task fetch");
      try {
        userData = await FirebaseFirestore.instance.collection('users');
        var temp = await userData
            .doc(userUid)
            .get();

        temp = temp.data();

        temp = temp["tasks"];

        print(temp);

        print(temp[0]);

        _tasks = [];

        for (var e in temp) {
          _tasks.add(Task(title: e["title"],
              description: e["description"],
              priority: e["priority"],
              priorityValue: e["priorityValue"],
              dueDate: e["dueDate"])
          );
        }

        notifyListeners();
        return;
      }
      catch (err) {
        print(err);
      }
    }
  }


  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return (_tasks);
  }

  Task task(index) {
    return _tasks[index];
  }

  void addTask(Task task) async {
    _tasks.add(task);

    try{

      var arr =  _tasks.map((e) => e.toJson()  ) ;
      print(arr);

      if(userData != null && userUid != null){
        await userData.doc(userUid).set({"tasks" : arr });
      }
      else{
        // save local
        await _databaseHelper.insertTask(task);
      }
    }
    catch(err){
      print(err);
    }

    notifyListeners();
  }

  void updateTask(Task task, int index) async{
    _tasks[index] = task;

    var arr =  _tasks.map((e) => e.toJson()  ) ;
    try{
      if(userData != null && userUid != null){
        print("in update");
        await userData.doc(userUid).set({"tasks" : arr});
      }
      else{
        await _databaseHelper.updateTask(task);
      }
    }
    catch(err){
      print(err);
    }

    notifyListeners();
  }

  void deleteTask(Task task) async{
    _tasks.remove(task);

    var arr =  _tasks.map((e) => e.toJson()  ) ;

    try{
      if(userData != null && userUid != null){
        await userData.doc(userUid).set({"tasks" : arr});
      }
      else{
        if(task.id != null) await _databaseHelper.deleteTask(task.id!);
      }
    }
    catch(err){
      print(err);
    }

    notifyListeners();
  }
}
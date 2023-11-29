import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier{
  String? title;
  String? description;
  String? priority;
  int? priorityValue;
  String? dueDate;

  bool isDone = false;

  Task({this.title, this.description, this.priority, this.priorityValue, this.dueDate});

  void updateTitle(String newTitle){
    title = newTitle;
    notifyListeners();
  }
}
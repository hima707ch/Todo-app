import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier{
  String? title;
  String? description;
  String? priority;
  int? priorityValue;
  String? dueDate;

  bool isDone = false;

  Task({this.title, this.description, this.priority, this.priorityValue, this.dueDate});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'priorityValue': priorityValue,
      'dueDate': dueDate,
    };
  }

}
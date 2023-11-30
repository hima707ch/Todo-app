import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier{
  String? title;
  String? description;
  String? priority;
  int? priorityValue;
  String? dueDate;
  int? id;

  bool isDone = false;

  Task({this.title, this.description, this.priority, this.priorityValue, this.dueDate});

  Task.withId({this.title, this.description, this.priority, this.priorityValue, this.dueDate, this.id});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'priorityValue': priorityValue,
      'dueDate': dueDate,
    };
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['priority'] = priority;
    map["priorityValue"] = priorityValue;
    map['dueDate'] = dueDate;

    return map;
  }

  Task.fromMap(Map<String,dynamic> map){
    this.id = map["id"];
    this.title = map["title"];
    this.description = map["description"];
    this.priority = map["priority"];
    this.priorityValue = map["priorityValue"];
    this.dueDate = map["dueDate"];
  }

}
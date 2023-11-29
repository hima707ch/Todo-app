import 'package:flutter/cupertino.dart';
import 'package:todo/models/task.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> _tasks = [
    // Task(title: 'Buy milk',description: "Make Coffe", priority: "Avrage", dueDate: "25-Nov"),
    // Task(title: 'Buy eggs',description: "Make Coffe", priority: "Avrage", dueDate: "25-Nov"),
    // Task(title: 'Buy bread',description: "", priority: "", dueDate: ""),
  ];

  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return (_tasks);
  }

  Task task(index) {
    return _tasks[index];
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task, int index){
    _tasks[index] = task;
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
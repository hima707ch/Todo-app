import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_list.dart';


class AddTaskScreen extends StatefulWidget {

  AddTaskScreen({required this.type, this.task, this.index});

  String type;
  Task? task;
  int? index;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String submitButton = "Add";
  int priorityValue = 2;

  final TextEditingController titleText = TextEditingController();

  final TextEditingController descriptionText = TextEditingController();

  final TextEditingController priorityText = TextEditingController();

  final TextEditingController dueDateText = TextEditingController();

  void init(){
    if(widget.type == "edit" && widget.task != null){
      titleText.text = widget.task!.title ?? "";
      descriptionText.text = widget.task!.description ?? "";
      priorityText.text = widget.task!.priority ?? "";
      dueDateText.text = widget.task!.dueDate ?? "";

      submitButton = "Edit";
    }

  }

  @override
  Widget build(BuildContext context) {

    init();

    String title = "";
    String description = "";
    String priority = "";
    String dueDate = "";

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: titleText,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Title",
              ),
              onChanged: (newText) {
                title = newText;
              },
            ),

            SizedBox(height: 20,),
            TextField(
              controller: descriptionText,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "description",
              ),
              onChanged: (newText) {
                description = newText;
              },
            ),
            SizedBox(height: 25,),

            Text("Choose Priority ${priorityText.text}"),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){
                  setState(() {
                    priorityText.text = "High" ;
                    priorityValue = 3;
                  });
                }, child: Text("High"), style: kButtonStyle,),
                TextButton(onPressed: (){setState(() {
                  priorityText.text = "Avrage" ;
                  priorityValue = 2;
                });}, child: Text("Avrage"), style: kButtonStyle,),
                TextButton(onPressed: (){setState(() {
                  priorityText.text = "Low" ;
                  priorityValue = 1;
                });},  child: Text("Low"), style: kButtonStyle,)
              ],
            ),

            TextField(
              controller: dueDateText,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Due Date",
              ),
              onChanged: (newText) {
                dueDate = newText;
              },
            ),

            SizedBox(height: 15,),

            TextButton(
              style: kButtonStyle,
              child: Text(
                submitButton,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20
                ),
              ),

              onPressed: () {

                title=titleText.text;
                description = descriptionText.text;
                priority = priorityText.text;
                dueDate = dueDateText.text;

                if(widget.type == "add"){
                  Task task = Task(title: title, description: description, priority: priority, dueDate: dueDate,priorityValue: priorityValue);
                  print( (  task.toJson() ) );
                  Provider.of<TaskListProvider>(context, listen: false).addTask(task);
                  Navigator.pop(context);
                }
                else{
                  Task task = Task(title: title, description: description, priority: priority, dueDate: dueDate,priorityValue: priorityValue);
                  Provider.of<TaskListProvider>(context, listen: false).updateTask(task, widget.index!);
                  Navigator.pop(context);
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/screens/add_task.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({super.key, required this.index});

  Task? task;
  int index;



  @override
  Widget build(BuildContext context) {

    void init(){
      task = Provider.of<TaskListProvider>(context).task(index);
    }

    init();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all( 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 45),
          Text("ToDo", style: TextStyle(decoration: TextDecoration.none,color:Colors.black,fontWeight: FontWeight.w600, fontSize: 45),),
          SizedBox(height: 15,),
          Text("Task no - ${index + 1}", style: TextStyle(decoration: TextDecoration.none,color:Colors.black,fontWeight: FontWeight.w600, fontSize: 25),),
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(" Title : ${task!.title!}", style: TextStyle(decoration: TextDecoration.none,color:Colors.black,fontWeight: FontWeight.w600, fontSize: 30),),

            ],
          ),
          SizedBox(height: 60),
          Text("Description : ${task!.description!}",style: TextStyle(decoration: TextDecoration.none,color:Colors.black, fontSize: 20)),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Priority : ${task!.priority!}", style: TextStyle(decoration: TextDecoration.none,color:Colors.black, fontSize: 20)),

            ],
          ),
          SizedBox(height: 60,),
          Text("Due Date : ${task!.dueDate!}", style: TextStyle(decoration: TextDecoration.none,color:Colors.black, fontSize: 20)),
          SizedBox(height: 120,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTaskScreen(type: "edit",task: task,index :index);
                  },
                );
              }, child: Text("Edit",style: TextStyle( fontSize: 20))),
              TextButton(onPressed: (){
                Provider.of<TaskListProvider>(context, listen: false).deleteTask(task!);
                Navigator.pop(context);
              }, child: Text("Delete",style: TextStyle( fontSize: 20))),
            ],
          )
        ],
      ),
    );
  }
}

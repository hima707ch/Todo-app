import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/widgets/task_details.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  List? tasks;

  bool sortPriority = false;
  bool sortDate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TaskListProvider>(context, listen: false).getLocal();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                setState(() {
                  sortDate = false;
                  sortPriority = true;
                });
              }, child: Text("Priority sort"), style: kButtonStyle,),
              TextButton(onPressed: (){
                setState(() {
                  sortPriority = false;
                  sortDate = true;
                });
              }, child: Text("Due date sort"), style: kButtonStyle,)
            ],
          ),

          SizedBox(height: 40,),

          Expanded(
            child: Consumer<TaskListProvider>(
              builder: (context, taskData, child) {

                tasks = taskData.tasks;

                if(tasks != null && sortPriority)
                tasks!.sort((a, b) => b.priorityValue.compareTo(a.priorityValue));

                if(tasks != null && sortDate)
                  tasks!.sort((a, b) => a.dueDate.compareTo(b.dueDate));

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final task = tasks![index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: TaskTile(
                        task: task,
                        index : index
                      ),
                    );
                  },
                  itemCount: taskData.taskCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.index
  });

  final Task task;
  final int index;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskDetails(index : widget.index) ));
      },
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.task.title ?? "", style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600, fontSize: 16),),
              Checkbox(value: isChecked, onChanged: (value){ setState(() {
                isChecked = value!;
              }); })
            ],
          ),
          SizedBox(height: 4),
          Text(widget.task.description ?? "",style: TextStyle(color:Colors.black)),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.task.priority ?? ""),
              Text(widget.task.dueDate ?? "")
            ],
          ),
          SizedBox(height: 4,)
        ],
      ),
    );
  }
}
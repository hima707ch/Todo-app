import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/screens/add_task.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/login.dart';
import 'package:todo/screens/register_user.dart';
import 'package:todo/widgets/task_list.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
         apiKey: "AIzaSyD2QBkVQ3b96uyaH_xHd9RY4gn7c5ZOU40",
        appId: "1:468832460917:android:adb88f5d4ed867b0d9983c",
        messagingSenderId: "468832460917",
         projectId: "todo-app-b3193",
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>TaskListProvider()),
      ],
      child: MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            body: HomePage(),
          ),
        ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        // Header
        Container(
          padding: EdgeInsets.only(
              top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 30.0,
                        color: Colors.lightBlueAccent,
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),

                  ),

                  TextButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddTaskScreen(type:  "add",);
                        },
                      );
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.add,
                        size: 30.0,
                        color: Colors.lightBlueAccent,
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),

                  )

                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Todo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${Provider.of<TaskListProvider>(context).taskCount} Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),

        // Tasks
        Expanded(
          child: TaskList(),
        ),
      ],
    );
  }
}




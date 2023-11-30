import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/screens/login.dart';

class Register extends StatelessWidget {
  Register({super.key});

  String? name;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(

            children: [
              SizedBox(height: 30,),
              Text("Register",style: TextStyle(fontSize: 25),),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Name"
                ),

                onChanged: (value){
                  name = value;
                },

              ),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter Email"
                ),

                onChanged: (value){
                  email = value;
                },

              ),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter Password"
                ),

                onChanged: (value){
                  password = value;
                },

              ),
              SizedBox(height: 60,),
              TextButton(onPressed: () async{
                try {
                  UserCredential user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: email, password: password);
                  print(user);
                  Fluttertoast.showToast(
                      msg: "User Created Successfully",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      timeInSecForIosWeb: 10
                  );

                  CollectionReference userData = await FirebaseFirestore.instance.collection('users');

                  await userData.doc(user.user!.uid).set({"name" : name});

                  Provider.of<TaskListProvider>(context,listen: false).setUid(user.user!.uid);

                  Navigator.pop(context);

                }
                catch(err){
                  Fluttertoast.showToast(
                    msg: err.toString(),
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    timeInSecForIosWeb: 10
                  );
                  print(err);
                }
              },
                child: Text("   Submit   "), style: kButtonStyle,),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have a account | "),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                  }, child: Text("Sign In"))
                ],
              )

            ],
          ),
        ),
      );
  }
}

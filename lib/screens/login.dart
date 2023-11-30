import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/screens/register_user.dart';

class Login extends StatelessWidget {
  Login({super.key});

  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(

          children: [
            SizedBox(height: 30,),
            Text("Login",style: TextStyle(fontSize: 25),),
            SizedBox(height: 30,),

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
                    .signInWithEmailAndPassword(
                    email: email!, password: password!);


                Provider.of<TaskListProvider>(context,listen: false).setUid(user.user!.uid);

                Navigator.pop(context);

              }
              catch(err){
                print(err);
              }
            }, child: Text("   Submit   "), style: kButtonStyle,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Need a account | "),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
                }, child: Text("Register"))
              ],
            )

          ],
        ),
      ),
    );
  }
}

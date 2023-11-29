import 'package:flutter/material.dart';
import 'package:todo/constants.dart';

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
            TextButton(onPressed: (){
              print(email);
            }, child: Text("   Submit   "), style: kButtonStyle,)

          ],
        ),
      ),
    );
  }
}
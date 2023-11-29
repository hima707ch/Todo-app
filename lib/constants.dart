import 'package:flutter/material.dart';

var kButtonStyle = TextButton.styleFrom(
  backgroundColor: Color(0xD5DEFFFF),
  padding: EdgeInsets.all(20),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0),
    side: BorderSide(
        color: Colors.blueAccent,
        width: 4.0// Set your desired border color
    ),
  ),
);
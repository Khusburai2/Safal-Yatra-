import 'package:flutter/material.dart';
import 'package:safalyatra/Home.dart';
import 'package:safalyatra/login.dart';
import 'package:safalyatra/signup.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'signup': (context) => SignUp(),
      'home': (context) => HomePage(), // Add route for home page
    },
  ));
}


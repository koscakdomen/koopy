import 'package:Koopy/authentication/signup.dart';
import 'package:Koopy/authentication/login.dart';
import 'package:Koopy/authentication/password.dart';
import 'package:Koopy/family/createFamily.dart';
import 'package:Koopy/homepage/homepage.dart';
import 'package:Koopy/splashscreen/splashscreen.dart';
import 'package:Koopy/theme.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    initialRoute: '/splashscreen',
    routes: {
      '/splashscreen': (context) => Splashscreen(),
      '/signup': (context) => SignUp(),
      '/signup_password': (context) => Password(),
      '/login': (context) => Login(),
      '/create_family': (context) => CreateFamily(),
      '/homepage': (context) => Homepage(),
    },
    debugShowCheckedModeBanner: false,
    theme: theme,
  ));
}

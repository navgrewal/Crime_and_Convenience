import 'package:flutter/material.dart';
import './Pages/home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheSocialMediaApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF2E3D7C) ,accentColor: Colors.cyan),
      home: Home(),
    );
  }
}


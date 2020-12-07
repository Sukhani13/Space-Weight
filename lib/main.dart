import 'package:flutter/material.dart';
import 'package:weight/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What is your weight?',
      home: HomePage(),
    );
  }
}

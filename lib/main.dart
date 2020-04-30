import 'package:flutter/material.dart';
import 'package:moritrade/page/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'あつ森交換ツール（仮）',
      theme: ThemeData(
        primaryColor: Colors.lightGreenAccent,
      ),
      home: MainPage(),
    );
  }
}
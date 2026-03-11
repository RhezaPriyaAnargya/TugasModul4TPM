import 'package:flutter/material.dart';
import 'pages/stopwatch_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stopwatch",
      home: StopwatchPage(),
    );
  }
}
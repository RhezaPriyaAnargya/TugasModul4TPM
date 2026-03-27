import 'package:flutter/material.dart';
import 'package:tugasmodul4/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), //INI KE LOGIN SCREEN DULU BARU MASUK KE HOME
    );
  }
}

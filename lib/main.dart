import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/pages/splash_screen.dart';
import 'package:medicine_app/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: SplashScreen(),
    );
  }
}

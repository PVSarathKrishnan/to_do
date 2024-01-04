import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/Screens/homescreen.dart';
import 'package:to_do/Screens/splash_screen.dart';

void main() async {
  await Hive.initFlutter(); //initialize Hive boc
  var box = await Hive.openBox("my_box"); //opening database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

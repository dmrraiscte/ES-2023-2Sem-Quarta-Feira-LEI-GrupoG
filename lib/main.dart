import 'package:calendar_manager/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//dgfdfgdfgdfg
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Home(),
    );
  }
}

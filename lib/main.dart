import 'dart:io';

import 'package:calendar_manager/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:calendar_manager/utils/utils.dart';
import 'package:file_picker/file_picker.dart';


void main() {
  Util.fromJsonToCSV(File("C:/Users/rafae/Downloads/events.json"), "C:/Users/rafae/OneDrive/Ambiente de Trabalho/teste.csv");
  runApp(const MyApp());
}

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

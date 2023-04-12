import 'package:calendar_manager/screens/filefromusl.dart';
import 'package:calendar_manager/screens/home.dart';
import 'package:calendar_manager/screens/pickfile.dart';
import 'package:calendar_manager/screens/saveFile.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "home",
      routes: {
        "filefromurl": (context) => const FileFromUrl(),
        "home": (context) => const Home(),
        "pickfile": (context) => const PickFile(),
        "savefile": (context) => const SaveFile(),
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}

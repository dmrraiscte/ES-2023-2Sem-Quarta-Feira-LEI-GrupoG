import 'package:calendar_manager/screens/filefromurl.dart';
import 'package:calendar_manager/screens/home.dart';
import 'package:calendar_manager/screens/pickfile.dart';
import 'package:calendar_manager/screens/savefile.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

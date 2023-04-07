import 'package:calendar_manager/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:calendar_manager/utils/utils.dart';
import "dart:io";
import 'package:flutter/services.dart' show rootBundle;

//import 'package:tuple/tuple.dart';

Future<void> main() async {
  /*Util.fromCSVToJSON(File(
          "C:/Users/lcvia/OneDrive/Documentos/GitHub/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/assets/files/horario-exemplo.csv")
      .readAsStringSync());
*/
  WidgetsFlutterBinding.ensureInitialized();
  Util.fromCSVToJSON(
      await rootBundle.loadString('assets/files/horario-exemplo.csv'));
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

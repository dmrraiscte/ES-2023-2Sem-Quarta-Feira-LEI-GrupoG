import 'package:calendar_manager/screens/all.dart';
import 'package:calendar_manager/screens/filefromurl.dart';
import 'package:calendar_manager/screens/home.dart';
import 'package:calendar_manager/screens/pickfile.dart';
import 'package:calendar_manager/screens/savefile.dart';
import 'package:flutter/material.dart';
import 'package:calendar_manager/screens/icstostring.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "all",
      routes: {
        "filefromurl": (context) => const FileFromUrl(),
        "home": (context) => const Home(),
        "pickfile": (context) => const PickFile(),
        "savefile": (context) => const SaveFile(),
        "icstostring": (context) => const IcsToString(),
        "all": (context) => const All()
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'PT'),
      ],
      locale: const Locale("pt", "PT"),
    );
  }
}

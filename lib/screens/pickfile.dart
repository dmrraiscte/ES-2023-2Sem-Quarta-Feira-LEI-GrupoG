import 'package:calendar_manager/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickFile extends StatefulWidget {
  const PickFile({super.key});

  @override
  State<PickFile> createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  var myText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick file"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(myText),
            ElevatedButton.icon(
                onPressed: () async {
                  var events = await Util.getEventsFromFile();
                  setState(() {
                    myText =
                        "Encontrados ${events.length.toString()} no ficheiro";
                  });
                },
                icon: const Icon(CupertinoIcons.tray_arrow_down_fill),
                label: const Text("Escolher ficheiro")),
          ],
        ),
      ),
    );
  }
}

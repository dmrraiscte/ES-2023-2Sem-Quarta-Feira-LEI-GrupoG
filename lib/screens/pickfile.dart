import 'dart:convert';

import 'package:calendar_manager/models/event_model.dart';
import 'package:calendar_manager/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
                  var allowedExtensions = ['csv', 'json'];
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: allowedExtensions);

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    if (allowedExtensions.contains(file.extension)) {
                      var data = utf8.decode(file.bytes!);
                      Tuple2<String, List<Event>>? conversionResult;
                      switch (file.extension) {
                        case 'csv':
                          conversionResult = Util.fromCSVToJSON(data);
                          break;
                        case 'json':
                          conversionResult = Util.fromJsonToCSV(data);
                          break;
                      }
                      setState(() {
                        myText =
                            "Encontrados ${conversionResult!.item2.length.toString()} no ficheiro ${file.name}";
                      });
                    } else {
                      // Show unrecognized file extension message
                      print("Unrecognized file extension");
                    }
                  }
                },
                icon: const Icon(CupertinoIcons.tray_arrow_down_fill),
                label: const Text("Escolher ficheiro")),
          ],
        ),
      ),
    );
  }
}

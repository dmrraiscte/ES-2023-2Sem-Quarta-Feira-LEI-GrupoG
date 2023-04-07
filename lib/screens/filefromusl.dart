import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/utils.dart';

class FileFromUrl extends StatefulWidget {
  const FileFromUrl({super.key});

  @override
  State<FileFromUrl> createState() => _FileFromUrlState();
}

class _FileFromUrlState extends State<FileFromUrl> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                setState(() {
                  inputText = text;
                });
              },
              decoration: const InputDecoration(
                hintText: 'URL',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Util.getEventsFromUrl(inputText);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

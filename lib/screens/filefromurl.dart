import 'package:flutter/material.dart';
import '../utils/file.dart';

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
                File.getEventsFromUrl(inputText);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

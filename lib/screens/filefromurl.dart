import 'package:flutter/material.dart';
import '../utils/file.dart';

class FileFromUrl extends StatefulWidget {
  const FileFromUrl({super.key});

  @override
  State<FileFromUrl> createState() => _FileFromUrlState();
}

class _FileFromUrlState extends State<FileFromUrl> {
  var inputText = "";
  var outputText = "Start Flag";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        'https://raw.githubusercontent.com/dmrraiscte/ES-2023-2Sem-Quarta-Feira-LEI-GrupoG/main/assets/files/small_test.csv';
  }

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
              controller: _controller,
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
              onPressed: () async {
                var lista = await File.getEventsFromUrl(_controller.text);
                var result = lista.map((e) => e.toString()).join('\n');
                setState(() {
                  outputText = result.isEmpty ? 'Vazio' : result;
                });
              },
              child: const Text('Submit'),
            ),
            Text(outputText)
          ],
        ),
      ),
    );
  }
}

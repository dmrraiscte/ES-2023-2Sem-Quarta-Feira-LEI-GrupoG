import 'package:flutter/material.dart';

import '../utils/conversion.dart';

class IcsToString extends StatefulWidget {
  const IcsToString({super.key});

  @override
  State<IcsToString> createState() => _IcsToStringState();
}

class _IcsToStringState extends State<IcsToString> {
  final TextEditingController _input = TextEditingController();
  final TextEditingController _output = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ICS to String testing'),
      ),
      body: Center(
          child: Column(
        children: [
          Flexible(
              flex: 8,
              child: TextField(
                minLines: 30,
                maxLines: 35,
                decoration: borderDecoration(),
                controller: _input,
                onChanged: (text) {
                  _input.text = text;
                },
              )),
          Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
                child: ElevatedButton(
                    onPressed: () {
                      _output.text = Conversion.icsToEventList(_input.text);
                    },
                    child: const Text('Test')),
              )),
          Flexible(
              flex: 8,
              child: TextField(
                minLines: 30,
                maxLines: 35,
                decoration: borderDecoration(),
                controller: _output,
              )),
        ],
      )),
    );
  }

  InputDecoration borderDecoration() {
    return const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.black)));
  }
}

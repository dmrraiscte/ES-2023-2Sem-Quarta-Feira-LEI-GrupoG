import 'package:flutter/material.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Screen teste layout'))),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                  border: BorderDirectional(), color: Colors.blue),
              child: const Center(
                child: Text('First Section'),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.green,
              child: const Center(
                child: Text('Second Section'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              child: const Center(
                child: Text('Third Section'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:big_bird/big_bird.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _bigBirdPlugin = BigBird();

  void printDocument() async {

    final content = Uint8List.fromList(utf8.encode("Hello, World!"));
    _bigBirdPlugin.printData(content);

  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    platformVersion = await _bigBirdPlugin.getPlatformVersion() ?? 'Unknown platform version';

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            //Text("Список принтеров: $_printers}"),
            TextButton(onPressed: printDocument, child: Text("Получить принтеры"))
          ]
        ),
      ),
    );
  }
}

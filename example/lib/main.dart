import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:big_bird/big_bird.dart';

import 'package:http/http.dart';

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
  String u = "https://downloader.disk.yandex.ru/disk/685e9b7147484090469ba3c406b35a7bda6639e7de17d6e3717e87e05aa03115/64762e39/sCGpPATvdgHiU_Y1g3zCSG6cP_PkMqe7GrPc8vmG4OnJ5GQrGzTLq2vgcIfpVn_vJiPVK_pRAl4EKyEq-Dc_AA%3D%3D?uid=0&filename=card_transfer_by_account_2023-05-29%20%282%29.pdf&disposition=attachment&hash=xL1g7WxytK2geyha6nG8LQJv3oOV/uk2BvlsGUsIv4Ss53xPKLOzln5PXZfwydvfq/J6bpmRyOJonT3VoXnDag%3D%3D&limit=0&content_type=application%2Fpdf&owner_uid=611191694&fsize=38483&hid=7334532d27a65eededc0eb4e10e64da5&media_type=document&tknv=v2";
  final _bigBirdPlugin = BigBird();

  void printDocument() async {

    var url = Uri.parse(u);
    var response = await get(url);

    var bytes = Uint8List.fromList(response.bodyBytes);

    _bigBirdPlugin.printData(bytes);

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
            TextButton(onPressed: printDocument, child: Text("Получить принтеры")),
          ]
        ),
      ),
    );
  }
}

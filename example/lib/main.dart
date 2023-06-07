import 'dart:convert';
import 'dart:ui';

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

  String _platformVersion = 'Неизвестная ОС';
  String u = "https://s568sas.storage.yandex.net/rdisk/1ce05954354bdef46d89691a9c1ed5b363277f87264171dfb86348c1f1445cf4/6480e414/sCGpPATvdgHiU_Y1g3zCSG6cP_PkMqe7GrPc8vmG4OnJ5GQrGzTLq2vgcIfpVn_vJiPVK_pRAl4EKyEq-Dc_AA==?uid=0&filename=card_transfer_by_account_2023-05-29%20%282%29.pdf&disposition=attachment&hash=xL1g7WxytK2geyha6nG8LQJv3oOV/uk2BvlsGUsIv4Ss53xPKLOzln5PXZfwydvfq/J6bpmRyOJonT3VoXnDag%3D%3D&limit=0&content_type=application%2Fpdf&owner_uid=611191694&fsize=38483&hid=7334532d27a65eededc0eb4e10e64da5&media_type=document&tknv=v2&rtoken=u8aaOkr0W0nf&force_default=no&ycrid=na-62044f2083536ed56a206576ff92ab17-downloader8f&ts=5fd8fb8322d00&s=019cd593c350fc963531cb10afc1f13370992d8827e36723326208b63187d26a&pb=U2FsdGVkX18zAjXw6TDizpVr2PdZ8Dw6495qQh9gbaXZNje-l0K-Qy6xUmTb-eZd-GmCNNY2ZVNIHA_wAgIi7zR5W_-U3_0iZHzBA4YLr4c";

  String q = "";

  final _bigBirdPlugin = BigBird();

  Image? img;

  void printDocument() async {

    var url = Uri.parse(u);
    var response = await get(url);

    var bytes = Uint8List.fromList(response.bodyBytes);

    var src = await _bigBirdPlugin.printData(bytes);

    setState(() {
      print(src);
      q = src;

      img = Image.network(src);
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    platformVersion = await _bigBirdPlugin.getPlatformVersion() ?? 'Неизвестная ОС';

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
          backgroundColor: Colors.lightGreen,
          title: Text('BIG BIRD :>'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Запущен на: $_platformVersion\n'),
                //Text("Список принтеров: $_printers}"),
                TextButton(onPressed: printDocument, child: Text("Печать")),
                TextButton(onPressed: () {getCanvasImage("ВАБА ЛАБА ДАБ ДАЮ");}, child: Text("Предпросмотр")),
                if (img != null)
                  img!,
              ]
          )
        ),
      ),
    );
  }


  void getCanvasImage(String str) async {
    var builder = ParagraphBuilder(ParagraphStyle(fontStyle: FontStyle.normal));
    builder.addText(str);
    Paragraph paragraph = builder.build();
    paragraph.layout(const ParagraphConstraints(width: 100));
    final recorder = PictureRecorder();
    var newCanvas = Canvas(recorder);
    newCanvas.drawParagraph(paragraph, Offset.zero);
    final picture = recorder.endRecording();
    var res = await picture.toImage(100, 100);
    ByteData? data = await res.toByteData(format: ImageByteFormat.png);
    if (data != null) {
      img = Image.memory(Uint8List.view(data.buffer));
    }
    setState(() {});
  }

}

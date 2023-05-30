import 'dart:html';
import 'dart:js';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'big_bird_platform_interface.dart';


class BigBirdWeb extends BigBirdPlatform {

  BigBirdWeb();

  static void registerWith(Registrar registrar) {
    BigBirdPlatform.instance = BigBirdWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = window.navigator.userAgent;
    return version;
  }

  @override
  Future printData(data) async {

    final id = 'iframe-${DateTime.now().millisecondsSinceEpoch}';

    final iframe = IFrameElement()
      ..id = id
      ..style.display = "none"
    ;

    final blob = Blob([data], 'application/pdf');
    final url = Url.createObjectUrlFromBlob(blob);
    iframe.src = url;

    document.body?.append(iframe);

    final contentWindow = context.callMethod('eval', ['document.getElementById("$id").contentWindow']);

    contentWindow.callMethod('eval', ['window.print();']);

    //TODO нужно будет сделать удаление iframe
    contentWindow.callMethod('setTimeout', [
          () => iframe.remove(),
      1000 * 60 * 5,
    ]);

  }
}

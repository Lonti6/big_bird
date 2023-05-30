import 'dart:html';
import 'dart:js';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'big_bird_platform_interface.dart';

/// A web implementation of the BigBirdPlatform of the BigBird plugin.
class BigBirdWeb extends BigBirdPlatform {
  /// Constructs a BigBirdWeb
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
      ..innerText = "https://portal.usue.ru/portal"
      ..id = id
      ..style.visibility = 'hidden';

    final blob = Blob([data], 'text/html');

    final url = Url.createObjectUrlFromBlob(blob);

    iframe.src = url;

    document.body!.append(iframe);

    final contentWindow = context.callMethod('eval', ['document.getElementById("$id").contentWindow']);

    contentWindow.callMethod('eval', ['window.print();']);

    contentWindow.callMethod('setTimeout', [
          () => iframe.remove(),
      1000,
    ]);

  }
}

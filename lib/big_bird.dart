
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'big_bird_platform_interface.dart';
import 'dart:async';


class BigBird {
  Future<String?> getPlatformVersion() {
    return BigBirdPlatform.instance.getPlatformVersion();
  }

  Future printData(Uint8List data) {
    return BigBirdPlatform.instance.printData(data);
  }

}

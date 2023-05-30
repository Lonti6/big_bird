
import 'dart:typed_data';

import 'big_bird_platform_interface.dart';

class BigBird {
  Future<String?> getPlatformVersion() {
    return BigBirdPlatform.instance.getPlatformVersion();
  }

  Future printData(Uint8List data) {
    return BigBirdPlatform.instance.printData(data);
  }
}

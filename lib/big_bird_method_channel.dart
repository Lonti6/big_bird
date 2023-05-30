import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'big_bird_platform_interface.dart';

class MethodChannelBigBird extends BigBirdPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('big_bird');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future printData(data) async {
    final version = await methodChannel.invokeMethod('printData', [data]);
    return version;
  }

}

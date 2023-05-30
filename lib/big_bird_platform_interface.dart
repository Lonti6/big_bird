import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'big_bird_method_channel.dart';

abstract class BigBirdPlatform extends PlatformInterface {
  /// Constructs a BigBirdPlatform.
  BigBirdPlatform() : super(token: _token);

  static final Object _token = Object();

  static BigBirdPlatform _instance = MethodChannelBigBird();

  static BigBirdPlatform get instance => _instance;

  static set instance(BigBirdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future printData(data) {
    throw UnimplementedError('printData() has not been implemented.');
  }
}

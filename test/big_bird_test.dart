import 'package:flutter_test/flutter_test.dart';
import 'package:big_bird/big_bird.dart';
import 'package:big_bird/big_bird_platform_interface.dart';
import 'package:big_bird/big_bird_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBigBirdPlatform
    with MockPlatformInterfaceMixin
    implements BigBirdPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BigBirdPlatform initialPlatform = BigBirdPlatform.instance;

  test('$MethodChannelBigBird is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBigBird>());
  });

  test('getPlatformVersion', () async {
    BigBird bigBirdPlugin = BigBird();
    MockBigBirdPlatform fakePlatform = MockBigBirdPlatform();
    BigBirdPlatform.instance = fakePlatform;

    expect(await bigBirdPlugin.getPlatformVersion(), '42');
  });
}

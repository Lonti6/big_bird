import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:big_bird/big_bird_method_channel.dart';

void main() {
  MethodChannelBigBird platform = MethodChannelBigBird();
  const MethodChannel channel = MethodChannel('big_bird');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openssl_crypto_flutter_libs/openssl_crypto_flutter_libs.dart';

void main() {
  const MethodChannel channel = MethodChannel('openssl_crypto_flutter_libs');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await OpensslCryptoFlutterLibs.platformVersion, '42');
  });
}

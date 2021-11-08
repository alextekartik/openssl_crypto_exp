import 'dart:async';

import 'package:flutter/services.dart';

export 'src/platform/platform.dart' show opensslCryptoInitFlutter;

class OpensslCryptoFlutterLibs {
  static const MethodChannel _channel =
      MethodChannel('openssl_crypto_flutter_libs');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

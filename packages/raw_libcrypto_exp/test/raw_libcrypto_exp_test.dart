import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:raw_libcrypto_exp/raw_libcrypto_exp.dart';
import 'package:raw_libcrypto_exp/src/third_party/openssl/crypto_generated_bindings.dart';
import 'package:test/test.dart';

import 'dart_pkg_crypto.dart';

void main() {
  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      if (Platform.isLinux) {
        final dylib = ffi.DynamicLibrary.open('libcrypto.so');
        opensslCrypto = OpensslCryptoBindings(dylib);
      }
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
      oscMD5();
      coreMd5();
    });
  });
}

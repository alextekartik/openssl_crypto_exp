@TestOn('vm')
library sqflite_common_ffi.test.setup_impl_test;

import 'dart:io';

import 'package:openssl_crypto_common_ffi/src/platform/windows/setup.dart';
import 'package:test/test.dart';

void main() {
  group('setup', () {
    test('findWindowsDllPath', () {
      expect(File(findWindowsDllPath()!).existsSync(), isTrue);
    });
  });
}

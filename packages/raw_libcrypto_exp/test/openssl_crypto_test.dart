import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:raw_libcrypto_exp/openssl_crypto.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('md5', () {
      var data = Uint8List.fromList([1, 2, 3]);
      expect(opensslCrypto.md5(data), crypto.md5.convert(data).bytes);
    });
  }, skip: opensslCryptoInitVm() ? null : 'No openssl crypto lib available');
}

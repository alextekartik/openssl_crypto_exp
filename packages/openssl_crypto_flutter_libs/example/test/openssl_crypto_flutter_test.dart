import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:openssl_crypto_common_ffi/openssl_crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OpensslCrypto', () {
    test('md5', () {
      var data = Uint8List.fromList([1, 2, 3]);
      expect(opensslCrypto.md5(data), crypto.md5.convert(data).bytes);
    });
  }, skip: opensslCryptoInitVm() ? null : 'No openssl crypto lib available');
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:openssl_crypto_common_ffi/openssl_crypto.dart';

void main() {
  var inputText = 'test';
  var data = Uint8List.fromList(utf8.encode(inputText));

  // MD5 encoding
  var result = opensslCrypto.md5(data);

  var hexResult = hex.encode(result);
  print('md5($inputText)');
  print(hexResult);
  // Should print:
  // md5(test)
  // 098f6bcd4621d373cade4e832627b4f6
}

import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

void coreMd5() {
  var out = md5.convert(utf8.encode('test'));
  print(out.bytes);
}

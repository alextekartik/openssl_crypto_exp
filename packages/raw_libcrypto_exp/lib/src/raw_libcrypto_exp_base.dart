// TODO: Put public facing types in this file.
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;
import 'package:raw_libcrypto_exp/src/third_party/openssl/crypto_generated_bindings.dart';

const allocate = ffi.malloc;
late OpensslCryptoBindings opensslCrypto;

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
  // MD5();
}

Pointer<Uint8> uint8ListToPointer(Uint8List bytes) {
  final ptr = allocate.allocate<Uint8>(bytes.length);

  ptr.asTypedList(bytes.length).setAll(0, bytes);

  return ptr;
}

void oscMD5() {
  var inBytes = Uint8List.fromList(utf8.encode('test'));
  var input = uint8ListToPointer(inBytes);
  //input.asTypedList(inBytes.length).
  var output = allocate.allocate<Uint8>(MD5_DIGEST_LENGTH);

  var result = opensslCrypto.MD5(input, inBytes.length, output);

  var bytes = result.asTypedList(MD5_DIGEST_LENGTH);
  print(bytes);
}

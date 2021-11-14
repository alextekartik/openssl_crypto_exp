import 'dart:typed_data';

abstract class OpensslCrypto {
  /// MD5 implementation
  Uint8List md5(Uint8List input);
}

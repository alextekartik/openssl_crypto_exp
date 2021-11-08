import 'dart:typed_data';

abstract class OpensslCrypto {
  Uint8List md5(Uint8List input);
}

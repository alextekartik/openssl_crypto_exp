import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:openssl_crypto_common_ffi/openssl_crypto.dart';
import 'package:openssl_crypto_common_ffi/src/openssl_crypto_globals.dart';
import 'package:openssl_crypto_common_ffi/src/third_party/openssl/crypto_generated_bindings.dart';

import 'load_library.dart';

class _OpensslCrypto implements OpensslCrypto {
  final OpensslCryptoBindings bindings;

  _OpensslCrypto(this.bindings);

  @override
  Uint8List md5(Uint8List bytes) {
    var input = uint8ListToPointer(bytes);
    //input.asTypedList(inBytes.length).
    var output = allocate.allocate<Uint8>(MD5_DIGEST_LENGTH);

    var result = bindings.MD5(input, bytes.length, output);

    var resultBytes = result.asTypedList(MD5_DIGEST_LENGTH);
    return resultBytes;
  }
}

_OpensslCrypto? _opensslCrypto;

/// Provides access to `sqlite3` functions, such as opening new databases.
OpensslCrypto get opensslCrypto {
  return _opensslCrypto ??=
      _OpensslCrypto(OpensslCryptoBindings(open.openOpensslCrypto()));
}

var _warningDisplayedOnce = false;

/// Check initialization on the VM
bool opensslCryptoInitVm() {
  try {
    opensslCrypto;
    return true;
  } catch (e) {
    if (_warningDisplayedOnce) {
      return false;
    }
    _warningDisplayedOnce = true;
    stderr.writeln('failed loading crypto library $e');
    if (Platform.isLinux) {
      stderr.writeln('On Linux you should install libssl-dev');
      stderr.writeln('\$ sudo apt-get install libssl-dev');
      stderr.writeln();
    } else if (Platform.isMacOS) {
      stderr.writeln('On MacOS you should install openssl using brew');
      stderr.writeln('\$ brew install openssl');
      stderr.writeln();
    }
    return false;
  }
}

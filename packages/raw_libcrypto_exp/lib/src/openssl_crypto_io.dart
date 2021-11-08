import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:raw_libcrypto_exp/openssl_crypto.dart';
import 'package:raw_libcrypto_exp/src/raw_libcrypto_exp_base.dart';
import 'package:raw_libcrypto_exp/src/third_party/openssl/crypto_generated_bindings.dart';

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

/// Check initialization on the VM
bool opensslCryptoInitVm() {
  try {
    opensslCrypto;
    return true;
  } catch (e) {
    stderr.writeln('failed loading crypto library $e');
    if (Platform.isLinux) {
      stdout.writeln('On Linux you should install openssl-dev');
      stdout.writeln('\$ sudo apt-get install openssl-dev');
      stdout.writeln();
    }
    return false;
  }
}

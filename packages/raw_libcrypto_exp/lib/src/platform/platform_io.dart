import 'package:raw_libcrypto_exp/openssl_crypto.dart';
import 'package:raw_libcrypto_exp/src/openssl_crypto_io.dart' as io;

/// Io implementation
OpensslCrypto get opensslCrypto => io.opensslCrypto;

/// Init OpenSSL for the vm (for VM, dart io and tests).
///
/// Not supported on the Web
bool opensslCryptoInitVm() => io.opensslCryptoInitVm();

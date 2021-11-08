import 'package:raw_libcrypto_exp/openssl_crypto.dart';

/// Main crypto entry point.
/// Not supported on the Web
OpensslCrypto get opensslCrypto => throw UnsupportedError('opensslCrypto');

/// Init OpenSSL for the vm (for VM, dart io and tests).
///
/// Not supported on the Web
bool opensslCryptoInitVm() => throw UnsupportedError('opensslCrypto');

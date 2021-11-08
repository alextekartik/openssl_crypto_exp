import 'package:openssl_crypto_flutter_libs/src/init_io.dart' as io;

/// Init OpenSSL for the vm (for VM, dart io and tests).
///
/// Not supported on the Web
Future<bool> opensslCryptoInitFlutter() => io.opensslCryptoInitFlutter();

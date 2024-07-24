import 'dart:io';

import 'package:dev_build/package.dart';
import 'package:path/path.dart';
import 'package:tekartik_crypto_support/linux_setup.dart';
import 'package:tekartik_crypto_support/macos_setup.dart';

String getPackagePath(String package) => join('..', 'packages', package);
Future main() async {
  try {
    if (Platform.isLinux) {
      await linuxSetup();
    } else if (Platform.isMacOS) {
      await macosSetup();
    }
  } catch (e) {
    print(e);
  }

  // Install libcrypto support
  for (var package in [
    'crypto_support',
    'openssl_crypto_common_ffi',
    'openssl_crypto_flutter_libs',
    join('openssl_crypto_flutter_libs', 'example'),
  ]) {
    await packageRunCi(getPackagePath(package));
  }
  await packageRunCi('.');
}

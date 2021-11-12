import 'dart:ffi';
import 'dart:io';

import 'package:openssl_crypto_common_ffi/src/platform/windows/setup_impl.dart';
import 'package:path/path.dart';

/// Get the dll path from our package path.
String packageGetCryptoDllPath(String packagePath) {
  var path = normalize(
      join(packagePath, 'src', 'platform', 'windows', 'libcrypto-1_1-x64.dll'));
  return path;
}

/// Find open my package
String? findPackagePath(String currentPath, {bool? windows}) {
  return packageFindPackagePath(currentPath, 'openssl_crypto_common_ffi',
      windows: windows);
}

/// Windows specific sqflite3 initialization.
///
/// binary copied from https://github.com/MobiliteDev/sqlcipher_library_windows/blob/737bbf40e00d6381df53dd2af4572be13716c12c/assets/libcrypto-1_1-x64.dll
/// on 2021/11/12
///
/// In debug mode: A bundled libcrypto-1_1-x64.dll from the openssl_crypto_common_ffi package
/// is loaded.
///
/// In release mode: libcrypto-1_1-x64.dll is needed next to the executable.
///
/// This code is only provided for reference.
DynamicLibrary getWindowsLibrary() {
  // Look for the bundle libcrypto-1_1-x64.dll while in development
  // otherwise make sure to copy the dll along with the executable
  var location = findPackagePath(Directory.current.path);
  if (location != null) {
    var path = packageGetCryptoDllPath(location);

    if (File(path).existsSync()) {
      return DynamicLibrary.open(path);
    }
  }
  Object? firstError;

  // Try to find in current and system folder
  var paths = ['libcrypto-1_1-x64.dll', 'libcryto.dll'];
  for (var path in paths) {
    try {
      return DynamicLibrary.open(path);
    } catch (e) {
      firstError ??= e;
    }
  }

  stderr.writeln('Failed to load libcrypto-1_1-x64.dll');
  throw firstError!;
}

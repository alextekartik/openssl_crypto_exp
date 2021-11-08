import 'dart:io';

import 'package:path/path.dart';
import 'package:process_run/shell.dart';
// https://developer.android.com/studio/projects/gradle-external-native-builds#jniLibs

/// You can delete .dart_tool and jniLib folder to restart the step
Future<void> main() async {
  var workDir = Directory(join('.dart_tool', 'work', 'download_crypto'));
  var packJniLibs = Directory(join('..', 'openssl_crypto_flutter_libs',
      'android', 'src', 'main', 'jniLibs'));
  await workDir.create(recursive: true);
  await packJniLibs.create(recursive: true);

  await workDir.create(recursive: true);
  var gitDir = Directory(join(workDir.path, 'openssl_prebuilt'));
  if (!gitDir.existsSync()) {
    var url = 'https://github.com/PurpleI2P/OpenSSL-for-Android-Prebuilt';

    await Shell()
        .run('git clone ${shellArgument(url)} ${shellArgument(gitDir.path)}');
  }

  var src = Directory(join(gitDir.path, 'openssl-1.1.1k-clang'));
  for (var dir in ['arm64-v8a', 'armeabi-v7a', 'x86', 'x86_64']) {
    var dstDir = join(packJniLibs.path, dir);
    await Directory(dstDir).create(recursive: true);
    for (var file in ['libcrypto.so', 'libcrypto.so.1.1']) {
      print('$dstDir $file');
      await File(join(src.path, dir, 'lib', file)).copy(join(dstDir, file));
    }
  }
}

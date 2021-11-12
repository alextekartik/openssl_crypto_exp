import 'dart:io';

import 'package:process_run/shell_run.dart';

/// Run me as `dart run tool/mac_setup.dart`
Future main() async {
  var force = false;
  await macosSetup(force: force);
}

Future macosSetup({bool force = false}) async {
  if (Platform.isMacOS) {
    if (!force) {
      force = (await which('openssl')) == null;
    }
    if (force) {
      if ((await which('brew')) != null) {
        // Use brew
        await run('brew install openssl');
      }
    }
  }
}

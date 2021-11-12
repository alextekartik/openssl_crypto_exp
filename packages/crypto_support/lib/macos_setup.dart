import 'dart:io';

import 'package:process_run/shell_run.dart';

/// Run me as `dart run tool/mac_setup.dart`
Future main() async {
  var force = false;
  await macosSetup(force: force);
}

Future macosSetup({bool force = false}) async {
  if (Platform.isMacOS) {
    if ((await which('brew')) != null) {
      var ok = false;
      try {
        var shell = Shell(
            verbose: false, commandVerbose: true); //, commandVerbose: true);
        var lines = (await shell.run('brew list openssl')).outLines;

        for (var line in lines) {
          // print(line);
          // at least a path found!
          if (line.startsWith('/')) {
            ok = true;
            break;
          }
        }
      } catch (_) {
        // Not installed!
      }

      if (!force) {
        force = !ok;
      }
      // print('ok: $ok, force: $force');
    }

    if (force) {
      await run('brew install openssl');
    }
  }
}

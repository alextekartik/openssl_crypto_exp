import 'dart:io';

import 'package:process_run/shell_run.dart';

/// Run me as `dart run tool/linux_setup.dart`
///
/// install will not work unless interactive
Future main() async {
  var force = false;
  var interractive = true;
  await linuxSetup(force: force, interractive: interractive);
}

/// Run me as `sudo dart run tool/linux_setup.dart`
Future linuxSetup({bool force = false, bool interractive = false}) async {
  var shellEnvironment = ShellEnvironment();
  if (interractive) {
    shellEnvironment.aliases['sudo'] = 'sudo --stdin';
  }
  var shell = Shell(environment: shellEnvironment);
  if (Platform.isLinux) {
    if (!force) {
      // Check if some existing file can tell more about whether it is installed
      force = !File('/usr/lib/x86_64-linux-gnu/libcrypto.so').existsSync();
    }
    if (force) {
      // Assuming ubuntu, to run as root, this is mainly for CI
      await shell.run('sudo apt-get -y install libssl-dev');
    }
  }
}

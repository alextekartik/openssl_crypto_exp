import 'package:tekartik_crypto_support/linux_setup.dart';

/// Run me as `dart run tool/linux_setup.dart`
///
/// install will not work unless interactive
Future main() async {
  var force = true;
  var interractive = true;
  await linuxSetup(force: force, interractive: interractive);
}

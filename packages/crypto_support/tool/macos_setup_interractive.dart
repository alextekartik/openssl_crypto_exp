import 'package:tekartik_crypto_support/macos_setup.dart';

/// install in interractive mode
Future main() async {
  var force = true;
  await macosSetup(force: force);
}

import 'package:process_run/shell.dart';

Future<void> main() async {
  await Shell().run('dart run ffigen');
}

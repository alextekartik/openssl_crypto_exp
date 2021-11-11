import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:openssl_crypto_common_ffi/openssl_crypto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            Row(
              children: const [
                Expanded(
                    child: ListTile(
                  title: Text('OpenSSL'),
                )),
                Expanded(
                    child: ListTile(
                  title: Text('Reference'),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: ListTile(
                  title: const Text('md5("test")'),
                  subtitle: FutureBuilder<String>(
                    future: () async {
                      return hex.encode(opensslCrypto
                          .md5(Uint8List.fromList(utf8.encode('test'))));
                    }(),
                    builder: (_, snapshot) => Text(snapshot.data ?? ''),
                  ),
                )),
                Expanded(
                    child: ListTile(
                  title: const Text('md5("test")'),
                  subtitle: FutureBuilder(
                    future: () async {
                      return null;
                    }(),
                    builder: (_, snapshot) => Text(
                        hex.encode(md5.convert(utf8.encode('test')).bytes)),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

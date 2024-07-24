OpenSSL libcrypto wrapper for dart (VM and flutter).

**Experimentation - No Support**

## Features

- Should allow dart & flutter tests on the desktop for easy development.
- Some crypto algorithm:
  - MD5

Some code were copied from webcryto:
- impl_ffi_utils
- test data

## Getting started

In `pubspec.yaml`:
```yaml
dependencies:
  openssl_crypto_common_ffi:
    git:
      url: https://github.com/alextekartik/openssl_crypto_exp
      path: packages/openssl_crypto_common_ffi
      ref: dart2_3
    version: '>=0.1.0'
```

## DartVM setup

### Linux setup

Ubuntu setup: Install openssl for development. It should work on DartVM and flutter apps.

```shell
$ sudo apt-get install libssl-dev
```

### Mac setup

Mac setup: install openssl using brew. On flutter it should work but an alternate solution like for for iOS could be
done.

```shell
$ brew install openssl
```

### Windows dartvm setup

The libcrypto is bundled for development of DartVM and flutter apps. In release mode,
The  [binary](packages/openssl_crypto_common_ffi/lib/src/platform/windows/libcrypto-1_1-x64.dll) should be copied along
with the executable.

## Example

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:openssl_crypto_common_ffi/openssl_crypto.dart';

/// OpenSSL crypto implementation (DartVM/IO/Flutter non-web)
var osc = opensslCrypto;

void main() {
  var inputText = 'test';
  var data = Uint8List.fromList(utf8.encode(inputText));

  // MD5 encoding
  var result = osc.md5(data);

  var hexResult = hex.encode(result);
  print('md5($inputText)');
  print(hexResult);
  // Should print:
  // md5(test)
  // 098f6bcd4621d373cade4e832627b4f6
}
```
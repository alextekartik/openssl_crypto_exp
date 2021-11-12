OpenSSL libcrypto wrapper for dart (VM and flutter).

## Features

- Should allow dart & flutter tests on the desktop for easy development.
- Some crypto algorithm:
  - MD5

## Getting started

In `pubspec.yaml`:
```yaml
dependencies:
  openssl_crypto_common_ffi:
    git: https://github.com/alextekartik.com/openssl_crypto_exp
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


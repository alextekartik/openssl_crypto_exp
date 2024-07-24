# openssl_crypto_flutter_libs

Open SSL flutter libs for Android and iOS

## Setup

In `pubspec.yaml`:

```dart
dependencies:
  openssl_crypto_flutter_libs:
    git:
      url: https://github.com/alextekartik/openssl_crypto_exp
      path: packages/openssl_crypto_flutter_libs
      ref: dart3a
    version: '>=0.1.0'
```

## Getting Started

This project exposes libcrypto for iOS and Android on flutter.

# Projet created with

```
flutter create --platforms ios -i objc --org com.tekartik -t plugin .
flutter create --platforms android -i java --org com.tekartik -t plugin .
```
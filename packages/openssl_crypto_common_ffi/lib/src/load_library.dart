/// Copied and adapted from Simon Binder sqlite3 function:
///
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:openssl_crypto_common_ffi/src/platform/windows/setup.dart';

/// Signature responsible for loading the dynamic library to use.
typedef OpenLibrary = DynamicLibrary Function();

enum OperatingSystem {
  android,
  linux,
  iOS,
  macOS,
  windows,
  fuchsia,
}

/// The instance managing different approaches to load the [DynamicLibrary]
/// when needed. See the documentation for [OpenDynamicLibrary] to learn
/// how the default opening behavior can be overridden.
final OpenDynamicLibrary open = OpenDynamicLibrary._();

DynamicLibrary _defaultOpen() {
  if (Platform.isLinux || Platform.isAndroid) {
    try {
      return DynamicLibrary.open('libcrypto.so');
    } catch (_) {
      if (Platform.isAndroid) {
        // On some (especially old) Android devices, we somehow can't dlopen
        // libraries shipped with the apk. We need to find the full path of the
        // library (/data/data/<id>/lib/libcrypto.so) and open that one.
        final appIdAsBytes = File('/proc/self/cmdline').readAsBytesSync();

        // app id ends with the first \0 character in here.
        final endOfAppId = max(appIdAsBytes.indexOf(0), 0);
        final appId = String.fromCharCodes(appIdAsBytes.sublist(0, endOfAppId));

        return DynamicLibrary.open('/data/data/$appId/lib/libcrypto.so');
      }

      rethrow;
    }
  } else if (Platform.isIOS) {
    try {
      return DynamicLibrary.open('openssl.framework/crypto');
      // Ignoring the error because its the only way to know if it was sucessful
      // or not...
      // ignore: avoid_catching_errors
    } on ArgumentError catch (_) {
      // In an iOS app without flutter_libs this falls back to using the version provided by iOS.
      // This version is different for each iOS release.
      return DynamicLibrary.process();
    }
  } else if (Platform.isMacOS) {
    DynamicLibrary result;

    // First, try to load embed library with Pod
    result = DynamicLibrary.process();

    // Check if the process includes libcrypto. If it doesn't, fallback to the
    // library from the system.
    if (!result.providesSymbol('MD5')) {
      for (var lib in [
        // For github actions and brew install, this looks like the best location
        // however this is openssl 3
        '/usr/local/opt/openssl@3/lib/libcrypto.dylib',
        '/usr/lib/libcrypto.dylib',
        '/usr/local/lib/libcrypto.dylib',
        '/usr/local/opt/openssl/lib/libcrypto.dylib'
        //'/usr/local/Cellar/openssl@1.1/1.1.1k/lib/libcrypto.dylib'
      ]) {
        // Load pre installed library on MacOS
        if (File(lib).existsSync()) {
          result = DynamicLibrary.open(lib);
          return result;
        }
      }
    }
    throw UnsupportedError('Missing openssl on ${Platform.operatingSystem}');
  }
  if (Platform.isWindows) {
    return getWindowsLibrary();
  }

  throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
}

/// Manages functions that define how to load the [DynamicLibrary] for openssl crypto.
///
/// The default behavior will use `DynamicLibrary.open('libcrypto.so')` on
/// Linux and Android, `DynamicLibrary.open('libcrypto.dylib')` on iOS and
/// macOS and `DynamicLibrary.open('libcrypto-1_1-x64.dll')` on Windows.
///
/// The default behavior can be overridden for a specific OS by using
/// [overrideFor]. To override the behavior on all platforms, use
/// [overrideForAll].
class OpenDynamicLibrary {
  final Map<OperatingSystem, OpenLibrary> _overriddenPlatforms = {};
  OpenLibrary? _overriddenForAll;

  OpenDynamicLibrary._();

  /// Returns the current [OperatingSystem] as read from the [Platform] getters.
  OperatingSystem? get os {
    if (Platform.isAndroid) return OperatingSystem.android;
    if (Platform.isLinux) return OperatingSystem.linux;
    if (Platform.isIOS) return OperatingSystem.iOS;
    if (Platform.isMacOS) return OperatingSystem.macOS;
    if (Platform.isWindows) return OperatingSystem.windows;
    if (Platform.isFuchsia) return OperatingSystem.fuchsia;
    return null;
  }

  /// Opens the [DynamicLibrary] from which `openssl_crypto` is going to
  /// [DynamicLibrary.lookup] methods that will be used. This method is
  /// meant to be called by `openssl_crypto` only.
  DynamicLibrary openOpensslCrypto() {
    final forAll = _overriddenForAll;
    if (forAll != null) {
      return forAll();
    }

    final forPlatform = _overriddenPlatforms[os];
    if (forPlatform != null) {
      return forPlatform();
    }

    return _defaultOpen();
  }

  /// Makes `moor_ffi` use the [open] function when running on the specified
  /// [os]. This can be used to override the loading behavior on some platforms.
  /// To override that behavior on all platforms, consider using
  /// [overrideForAll].
  /// This method must be called before opening any database.
  ///
  /// When using the asynchronous API over isolates, [open] __must be__ a top-
  /// level function or a static method.
  void overrideFor(OperatingSystem os, OpenLibrary open) {
    _overriddenPlatforms[os] = open;
  }

  // ignore: use_setters_to_change_properties
  /// Makes `moor_ffi` use the [OpenLibrary] function for all Dart platforms.
  /// If this method has been called, it takes precedence over [overrideFor].
  /// This method must be called before opening any database.
  ///
  /// When using the asynchronous API over isolates, [open] __must be__ a top-
  /// level function or a static method.
  void overrideForAll(OpenLibrary open) {
    _overriddenForAll = open;
  }

  /// Clears all associated open helpers for all platforms.
  @visibleForTesting
  void reset() {
    _overriddenForAll = null;
    _overriddenPlatforms.clear();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whistler/products/config/env/app_environment.dart';

/// The `AppInit` class in Dart is defining a class named `AppInit` with a method `init()` that is
/// responsible for initializing the application. Here's a breakdown of what the `init()` method is
/// doing:
final class AppInit {
  /// The `init` function initializes the Flutter app by ensuring the Flutter binding is initialized,
  /// setting the preferred orientation to portrait up, initializing Hive for data storage, and setting
  /// the app environment to general.
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// Allows the hiveflutter package to initialize.
    await Hive.initFlutter();

    /// Sets the app environment to general.
    AppEnvironment.general();
  }
}

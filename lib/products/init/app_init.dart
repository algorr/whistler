import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whistler/products/config/env/app_environment.dart';

final class AppInit {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    AppEnvironment.general();
  }
}

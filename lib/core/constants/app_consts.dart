import 'package:whistler/products/config/env/app_environment.dart';

final class AppConsts {
  /// Service endpoint and other consts
  static const String apiModel = 'whisper-1';
  static const String post = 'POST';
  static const String languageEnglish = 'en';
  static const String languageTurkish = 'tr';
  static Map<String, String> header =
      ({'Authorization': 'Bearer ${AppEnvironment.apiKey}'});

  /// UI consts
  static const String appName = 'Whistler';
  static const String fontFamily = 'Ubuntu';
}

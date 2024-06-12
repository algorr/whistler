import 'package:envied/envied.dart';
import 'package:whistler/products/config/env/app_configuration.dart';

part 'env_dev.g.dart';

/// This Dart code snippet is defining a class named `DevEnv` that implements the `AppConfiguration`
/// interface. The class is annotated with `@Envied` which is likely a custom annotation used for
/// handling environment variables.
@Envied(path: 'assets/env/.dev.env', obfuscate: true)
final class DevEnv implements AppConfiguration {
  /// BaseUrl of Dev Environment
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnv._baseUrl;

  /// ApiKey of Dev Environment
  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _DevEnv._apiKey;

  /// ApiUrl of Dev Environment
  @EnviedField(varName: 'URL')
  static final String _url = _DevEnv._url;

  /// Allows the get apiKey method to be called on the class on Dev Environment.
  @override
  String get apiKey => _apiKey;

  /// Allows the get baseUrl method to be called on the class on Dev Environment.
  @override
  String get baseUrl => _baseUrl;

  /// Allows the get apiUrl method to be called on the class on Dev Environment.
  @override
  String get url => _url;
}

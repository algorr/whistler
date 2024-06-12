import 'package:envied/envied.dart';
import 'package:whistler/products/config/env/app_configuration.dart';

part 'env_prod.g.dart';

/// This Dart code snippet is defining a class named `ProdEnv` that implements the `AppConfiguration`
/// interface. The class is annotated with `@Envied` which is likely a custom annotation used for
/// handling environment variables.
@Envied(path: 'assets/env/.prod.env', obfuscate: true)
final class ProdEnv implements AppConfiguration {
  // BaseUrl of Prod Environment
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnv._baseUrl;

  /// ApiKey of Prod Environment
  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _ProdEnv._apiKey;

  /// ApiUrl of Prod Environment
  @EnviedField(varName: 'URL')
  static final String _url = _ProdEnv._url;

  /// Allows the get apiKey method to be called on the class on Prod Environment.
  @override
  String get apiKey => _apiKey;

  /// Allows the get baseUrl method to be called on the class on Prod Environment.
  @override
  String get baseUrl => _baseUrl;

// Allows the get apiUrl method to be called on the class on Prod Environment.
  @override
  String get url => _url;
}

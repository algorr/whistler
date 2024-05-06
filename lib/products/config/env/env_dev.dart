import 'package:envied/envied.dart';
import 'package:whistler/products/config/env/app_configuration.dart';

part 'env_dev.g.dart';

@Envied(path: 'assets/env/.dev.env', obfuscate: true)
final class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnv._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _DevEnv._apiKey;

  @EnviedField(varName: 'URL')
  static final String _url = _DevEnv._url;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get url => _url;
}

import 'package:envied/envied.dart';
import 'package:whistler/products/config/env/app_configuration.dart';

part 'env_prod.g.dart';

@Envied(path: 'assets/env/.prod.env', obfuscate: true)
final class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnv._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _ProdEnv._apiKey;

  @EnviedField(varName: 'URL')
  static final String _url = _ProdEnv._url;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;

  @override
  String get url => _url;
}

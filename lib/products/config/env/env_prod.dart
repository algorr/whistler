import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: 'assets/env/.prod.env', obfuscate: true)
final class ProdEnv {
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _ProdEnv.baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _ProdEnv.apiKey;
}

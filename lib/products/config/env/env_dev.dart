import 'package:envied/envied.dart';

part 'env_dev.g.dart';

@Envied(path: 'assets/env/.dev.env', obfuscate: true)
final class DevEnv {
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _DevEnv.baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String apiKey = _DevEnv.apiKey;
}

import 'package:whistler/products/config/env/app_configuration.dart';
import 'package:whistler/products/config/env/env_prod.dart';

/// App environment class
final class AppEnvironment {
  /// Setup the app environment
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  AppEnvironment.general() {
    _config = ProdEnv();
  }

  /// App configuration
  static late final AppConfiguration _config;

  /// Base URL for the Whistler API
  static String get baseUrl => _config.baseUrl;

  /// API key for the Whistler API
  static String get apiKey => _config.apiKey;
}

/// App environment items
enum AppEnvironmentItems {
  baseUrl,
  apiKey;

  /// Get the value of the item
  String get value {
    switch (this) {
      case AppEnvironmentItems.baseUrl:
        return AppEnvironment._config.baseUrl;
      case AppEnvironmentItems.apiKey:
        return AppEnvironment._config.apiKey;
    }
  }
}

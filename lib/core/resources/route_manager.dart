import 'package:flutter/material.dart';
import 'package:whistler/core/resources/string_manager.dart';
import 'package:whistler/features/view/home/home_view.dart';
import '../../features/view/splash/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String mainRoute = '/home';
  static const String initRoute = '/init';
}

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      /*  case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView()); */

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.oppsss),
        ),
      ),
    );
  }
}

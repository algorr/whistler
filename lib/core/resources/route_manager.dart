/* import 'package:flutter/material.dart';
import 'package:picked/features/resources/string_manager.dart';
import 'package:picked/features/view/authentication/authentication_view.dart';
import 'package:picked/features/view/home/home_view.dart';
import 'package:picked/features/view/names/names_view.dart';
import 'package:picked/features/view/onboarding/onboarding_view.dart';
import 'package:picked/features/view/profile/profile_view.dart';
import 'package:picked/features/view/splash/splash_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String mainRoute = '/home';
  static const String namesRoute = '/names';
  static const String registerRoute = '/register';
  static const String profileRoute = '/profile';
  static const String logicRoute = '/logic';
  static const String initRoute = '/init';
  static const String denemeRoute = '/deneme';
}

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.namesRoute:
        return MaterialPageRoute(builder: (_) => const NamesView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const AuthenticationView());
      case Routes.logicRoute:
        return MaterialPageRoute(builder: (_) => AuthLogicView());
      case Routes.profileRoute:
        return MaterialPageRoute(
            builder: (_) => const ProfileView(
                  myUser: null,
                ));

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
 */
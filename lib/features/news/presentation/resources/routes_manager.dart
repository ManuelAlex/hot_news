import 'package:flutter/material.dart';
import 'package:hot_news/features/news/presentation/views/main_view.dart';
import 'package:hot_news/features/news/presentation/views/onboarding_chips_view.dart';
import 'package:hot_news/features/news/presentation/views/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String home = '/home';
  static const String onBoardingChips = '/onBoardingChips';
  static const String headLine = '/headLine';
  static const String settings = '/settings';
  static const String detailsScreen = '/news-details';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute<dynamic>(builder: (_) => const MainView());
      case Routes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoardingChips:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OnBoardingChipsView(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('No ROute Found'),
          ),
        ),
      );
}

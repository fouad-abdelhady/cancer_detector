import 'package:cancer_detector/screens/detector_screen.dart';
import 'package:cancer_detector/screens/home_screen.dart';
import 'package:cancer_detector/screens/login_screen.dart';
import 'package:cancer_detector/screens/register_screen.dart';
import 'package:cancer_detector/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ScreensRouter {
  static final ScreensRouter _router = ScreensRouter._internal();
  factory ScreensRouter() => _router;
  ScreensRouter._internal();

  MaterialPageRoute onGenerateRoute({required RouteSettings settings}) {
    switch (settings.name) {
      case SplashScreen.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(), settings: settings);
      case HomeScreen.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case LoginScreen.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(), settings: settings);
      case RegisterScreen.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => const RegisterScreen(), settings: settings);
      case DetectorScreen.PAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => const DetectorScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
    }
  }
}

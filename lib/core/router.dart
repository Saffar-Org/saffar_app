import 'package:flutter/material.dart';
import 'package:saffar_app/features/payment/presenter/screens/payment_screen.dart';
import 'package:saffar_app/features/splash/presenter/screens/splash_screen.dart';
import 'package:saffar_app/features/view_map/presenter/screens/view_map_screen.dart';

import '../features/authentication/presenter/screens/sign_in_screen.dart';
import '../features/authentication/presenter/screens/sign_up_screen.dart';


/// Handles routing in the app
class CustomRouter {
  /// Generates initial routes
  static List<Route<dynamic>> onGenerateInitialRoutes(String name) {
    return [
      MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    ];
  }

  /// Generates routes for named navigation
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PaymentScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            paymentScreenArguments:
                settings.arguments as PaymentScreenArguments,
          ),
        );
      case ViewMapScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ViewMapScreen(
            viewMapScreenArguments:
                settings.arguments as ViewMapScreenArguments,
          ),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route with the name ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}

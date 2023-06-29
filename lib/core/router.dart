import 'package:flutter/material.dart';
import 'package:saffar_app/features/authentication/presenter/view/sign_in_screen.dart';
import 'package:saffar_app/wrapper.dart';

import '../features/authentication/presenter/view/sign_up_screen.dart';

/// Handles routing in the app
class CustomRouter {
  /// Generates initial routes
  static List<Route<dynamic>> onGenerateInitialRoutes(String name) {
    return [
      MaterialPageRoute(
        builder: (_) => const Wrapper(),
      ),
    ];
  }

  /// Generates routes for named navigation
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
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

import 'package:flutter/material.dart';
import 'package:saffar_app/features/authentication/presenter/view/sign_in_screen.dart';

/// Handles routing in the app
class CustomRouter {
  /// Generates initial routes
  static List<Route<dynamic>> onGenerateInitialRoutes(String name) {
    return [
      MaterialPageRoute(
        builder: (_) => const SignInScreen(),
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

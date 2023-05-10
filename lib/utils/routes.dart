import 'package:flutter/material.dart';

import 'route_name.dart';
import '../screen/dashboard_screen.dart';
import '../screen/login_scree.dart';
import '../screen/registration_screen.dart';
import '../screen/splash_screen.dart';



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash_screen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.registration_screen:
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
            case RouteName.login_screen:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen());
             case RouteName.dashboard_screen:
        return MaterialPageRoute(
            builder: (context) => const DashBoardScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Text("No proper Route Defined"),
            );
          },
        );
    }
  }
}

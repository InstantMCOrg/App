import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/screens/dashboard_screen.dart';
import 'package:InstantMC/ui/screens/home_screen.dart';
import 'package:InstantMC/ui/screens/login_screen.dart';
import 'package:InstantMC/ui/screens/required_password_change_screen.dart';
import 'package:InstantMC/ui/screens/start_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route route(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.start:
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>  const HomeScreen());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) =>  const DashboardScreen());
      case Routes.passwordChange:
        return MaterialPageRoute(builder: (_) =>  const RequiredPasswordChangeScreen());
    }
    // default route
    return MaterialPageRoute(builder: (_) =>  const HomeScreen());
  }
}
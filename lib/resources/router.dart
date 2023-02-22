import 'package:InstantMC/resources/routes.dart';
import 'package:InstantMC/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route route(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) =>  const HomeScreen());
    }
    // default route
    return MaterialPageRoute(builder: (_) =>  const HomeScreen());
  }
}
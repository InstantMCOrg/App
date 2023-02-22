import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/resources/router.dart';
import 'package:InstantMC/ui/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const InstantMC());
}

class InstantMC extends StatelessWidget {
  const InstantMC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      initialRoute: "/",
      onGenerateRoute: AppRouter.route,
      theme: ThemeManager.dark(),
    );
  }
}

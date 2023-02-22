import 'package:InstantMC/ui/color_manager.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static ThemeData dark() {
    final colors = ColorManager.dark();

    return ThemeData(
      colorScheme: ColorScheme(
        background: colors.primary,
        brightness: Brightness.dark,
        error: colors.error,
        onBackground: colors.secondary,
        onError: colors.error,
        onPrimary: colors.secondary,
        onSecondary: colors.accent,
        onSurface: colors.secondary,
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.secondary,
      ),
      scaffoldBackgroundColor: colors.primary,
      appBarTheme: AppBarTheme(
        elevation: 0,

      )
    );
  }
}
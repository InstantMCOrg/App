import 'package:InstantMC/ui/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData dark() {
    final colors = ColorManager.dark();

    return ThemeData(
      colorScheme: ColorScheme(
        background: colors.primary,
        brightness: Brightness.dark,
        error: ColorManager.error,
        onBackground: colors.secondary,
        onError: ColorManager.error,
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
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: colors.primary
      ),
      cardColor: colors.cardBackgroundColor,
      textTheme: TextTheme(
        labelMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )
      )
    );
  }
}
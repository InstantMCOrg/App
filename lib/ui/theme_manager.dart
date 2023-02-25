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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.accent,
        selectionColor: colors.accent,
        selectionHandleColor: colors.accent,
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
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.grey
        ),
        // we dont use titelLarge because that overrides the appbars text style
        displayLarge: GoogleFonts.poppins(
          fontSize: 30,
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 20,
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 15,
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(colors.secondary),
          foregroundColor: MaterialStateProperty.all<Color>(ColorManager.white)
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(
          color: colors.secondary,
        ),
        floatingLabelStyle: TextStyle(
          color: colors.accent
        ),
        // when input is not focused
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.accent,
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.accent,
        circularTrackColor: Colors.red,
        linearTrackColor: colors.secondary
      )
    );
  }
}
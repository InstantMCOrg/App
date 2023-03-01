import 'dart:ui';

class ColorManager {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color onPrimary;

  static const Color error = Color.fromRGBO(255, 51, 51, 1);
  static const Color cardBackgroundColor = Color.fromRGBO(59, 58, 65, 1);
  static const Color borderColor = Color.fromRGBO(67, 67, 76, 1);
  static const Color borderFillColor = Color.fromRGBO(30, 28, 36, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(21, 19, 28, 1);
  static const Color grey = Color.fromRGBO(127, 128, 139, 1);
  static const Color success = Color.fromRGBO(75, 181, 67, 1);

  ColorManager.old() :
        primary = const Color.fromRGBO(21, 27, 41, 1),
        onPrimary = const Color.fromRGBO(31, 47, 85, 1),
        secondary = const Color.fromRGBO(31, 47, 85, 1),
        accent = const Color.fromRGBO(78, 164, 201, 1);
  
  ColorManager.dark() :
      primary = const Color.fromRGBO(24, 23, 31, 1),
      onPrimary = const Color.fromRGBO(29, 28, 35, 1),
      secondary = const Color.fromRGBO(59, 58, 65, 1),
      accent = const Color.fromRGBO(255, 255, 255, 1);

}
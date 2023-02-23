import 'dart:ui';

class ColorManager {
  final Color primary;
  final Color secondary;
  final Color accent;

  static const Color error = Color.fromRGBO(255, 51, 51, 1);
  final Color cardBackgroundColor = const Color.fromRGBO(59, 58, 65, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(21, 19, 28, 1);

  ColorManager.dark() :
        primary = const Color.fromRGBO(21, 27, 41, 1),
        secondary = const Color.fromRGBO(31, 47, 85, 1),
        accent = const Color.fromRGBO(78, 164, 201, 1);
}
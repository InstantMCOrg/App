import 'dart:ui';

class ColorManager {
  final Color primary;
  final Color secondary;
  final Color accent;

  final Color error = const Color.fromRGBO(255, 51, 51, 1);
  ColorManager.dark() :
        primary = const Color.fromRGBO(21, 27, 41, 1),
        secondary = const Color.fromRGBO(31, 47, 85, 1),
        accent = const Color.fromRGBO(78, 164, 201, 1);
}
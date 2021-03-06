import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Color selectedColor = Colors.deepPurple;
  static const Color blue = Colors.blue;
  static const Color lightBlue = Colors.lightBlue;
  static const Color grey = Colors.grey;
  static const Color primaryColor = Color(0xff0c9869);
  static const Color textColor = Color(0xff3c4046);
  static const Color backgroundColor = Color(0xfff9f8fd);

  static const Map<int, Color> orange = <int, Color>{
    50: Color(0xFFFCF2E7),
    100: Color(0xFFF8DEC3),
    200: Color(0xFFF3C89C),
    300: Color(0xFFEEB274),
    400: Color(0xFFEAA256),
    500: Color(0xFFE69138),
    600: Color(0xFFE38932),
    700: Color(0xFFDF7E2B),
    800: Color(0xFFDB7424),
    900: Color(0xFFD56217)
  };
}

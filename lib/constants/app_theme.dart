import 'package:flutter/material.dart';
import 'package:real_estate/constants/font_family.dart';

import 'colors.dart';

final ThemeData themeData = ThemeData(
    // fontFamily: FontFamily.productSans,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.orange[500]!.value, AppColors.orange),
    primaryColor: AppColors.orange[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.orange[500],
    accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  // fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);
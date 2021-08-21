
import 'package:flutter/material.dart';
import 'package:real_estate/ui/home/home.dart';
import 'package:real_estate/ui/search/search_result.dart';
import 'package:real_estate/ui/splash/splash.dart';
import 'package:real_estate/ui/tab_page.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/';
  static const String tab = '/tab';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    tab: (BuildContext context) => TabsPage(),
    home: (BuildContext context) => HomeScreen(),
  };
}


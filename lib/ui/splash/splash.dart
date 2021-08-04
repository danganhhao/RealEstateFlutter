import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_estate/data/sharedpref/constants/preferences.dart';
import 'package:real_estate/utils/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("Splash screen!!")),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.of(context).pushReplacementNamed(Routes.home);
    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //   Navigator.of(context).pushReplacementNamed(Routes.home);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.login);
    // }
  }
}

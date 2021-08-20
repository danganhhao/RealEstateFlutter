import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_estate/data/sharedpref/constants/preferences.dart';
import 'package:real_estate/utils/routes/routes.dart';
import 'package:real_estate/widgets/gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoTranslateAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();
    _logoController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() => setState(() {}));
    _logoTranslateAnimation = Tween(begin: 50.0, end: 0.0).animate(_logoController);
    _logoScaleAnimation = Tween(begin: 0.9, end: 1.0).animate(_logoController);
    _logoController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          const GradientBackground(),
          Transform.translate(
            child: Transform.scale(
              scale: _logoScaleAnimation.value,
              child: Center(
                  child: Image.asset(
                "assets/icons/logo.png",
                width: 300,
                height: 150,
              )),
            ),
            offset: Offset(0.0, _logoTranslateAnimation.value),
          ),
        ],
      ),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.of(context).pushReplacementNamed(Routes.tab);
    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //   Navigator.of(context).pushReplacementNamed(Routes.home);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.login);
    // }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }
}

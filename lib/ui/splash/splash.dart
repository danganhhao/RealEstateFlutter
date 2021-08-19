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
  late Animation<double> _fadeIn;
  late Animation<double> _textScaleAnimation;

  @override
  void initState() {
    super.initState();
    startTimer();
    _logoController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..addListener(() => setState(() {}));
    _logoTranslateAnimation = Tween(begin: 0.0, end: -25.0).animate(_logoController);
    _logoScaleAnimation = Tween(begin: 1.0, end: 0.75).animate(_logoController);
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(_logoController);
    _textScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_logoController);
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
                "assets/icons/logo1.png",
                width: 150,
                height: 150,
              )),
            ),
            offset: Offset(0.0, _logoTranslateAnimation.value),
          ),
          FadeTransition(
            opacity: _fadeIn,
            child:
            Transform.scale(
              scale: _textScaleAnimation.value,
              child: const Center(
                child: Text(
                  "Welcome to\n\t\tHadana",
                  style: TextStyle(
                      fontFamily: "Marvel", fontSize: 50, color: Colors.white),
                ),
              ),
            ),
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
    // Navigator.of(context).pushReplacementNamed(Routes.tab);
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

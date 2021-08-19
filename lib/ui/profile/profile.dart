import 'package:flutter/material.dart';
import 'package:real_estate/ui/profile/profile_background.dart';

class ProfileScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const ProfileBackground(),
          SafeArea(
              child: Stack(
            children: [
              Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    "Welcome to\n\t\tHadana",
                    style: TextStyle(
                        fontFamily: "Marvel",
                        fontSize: 50,
                        color: Colors.white),
                  )),
              Positioned(
                  top: size.height * .5 - 75,
                  child: Center(
                    child: Image.asset(
                      "assets/icons/logo1.png",
                      width: 150,
                      height: 150,
                    ),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}

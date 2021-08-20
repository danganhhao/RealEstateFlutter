import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
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
              // Positioned(
              //     top: size.height * .5 - 175,
              //     left: size.width * .5 - 75,
              //     child: Text(
              //       "Welcome to\n\t\tHadana",
              //       style: TextStyle(
              //           fontFamily: "Marvel",
              //           fontSize: 50,
              //           color: Colors.white),
              //     )),
              Positioned(
                  top: -50,
                  left: -30,
                  child: Center(
                    child: Image.asset(
                      "assets/icons/logo.png",
                      width: 300,
                      height: 300,
                    ),
                  )),
              Positioned(
                top: size.height * .5,
                left: size.width * .5,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: AppColors.primaryColor,
                  onPressed: () {},
                  child: Text("More", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

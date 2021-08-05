import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.default_padding),
      child: Row(
        children: [
          TitleWithCustomUnderline(text: title),
          Spacer(),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: AppColors.primaryColor,
            onPressed: press,
            child: Text("More", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimens.default_padding / 4),
            child: Text(text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(left: Dimens.default_padding / 4),
              height: 4,
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

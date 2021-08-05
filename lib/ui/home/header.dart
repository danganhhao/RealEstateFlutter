import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';

class HeaderSearchBoxWidget extends StatelessWidget {
  const HeaderSearchBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      margin: const EdgeInsets.only(bottom: Dimens.default_padding * 1.5),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: Dimens.default_padding,
                right: Dimens.default_padding,
                bottom: 36 + Dimens.default_padding),
            height: size.height * 0.2 - 27,
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Row(
              children: [
                Text(
                  "Real Estate!",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ClipOval(
                    child: Image.asset("assets/icons/icon1.jpg",
                        width: 40, height: 40, fit: BoxFit.cover)),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.default_padding),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.default_padding),
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: AppColors.primaryColor.withOpacity(0.23)),
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: AppColors.primaryColor.withOpacity(0.5)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

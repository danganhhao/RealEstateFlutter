import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.size,
    required this.item,
  }) : super(key: key);

  final Size size;
  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: Dimens.default_padding / 4),
      width: size.width * 0.4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: (item.images != null && item.images!.isNotEmpty == true)
                ? FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                    width: size.width * 0.4,
                    height: size.width * 0.4,
                    image: item.images![0].image ?? "",
                  )
                : Image.asset(
                    "assets/images/placeholder.jpg",
                    fit: BoxFit.fill,
                    width: size.width * 0.4,
                    height: size.width * 0.4,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimens.default_padding / 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                      color: AppColors.primaryColor.withOpacity(0.23))
                ]),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${item.title!.substring(1, 15)}",
                          style: Theme.of(context).textTheme.button),
                      TextSpan(
                        text: "\n${item.area ?? 0.0 * 1000} m2",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 10),
                      ),
                      TextSpan(
                        text: "\n${item.district}, ${item.province}",
                        style: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.5),
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "${item.price ?? 0.0 * 1000}\$",
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

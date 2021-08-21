import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';

class SearchPostItem extends StatelessWidget {
  final PostItem data;

  const SearchPostItem({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final title = "${data.id}.${data.title}";
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 5, horizontal: 5),
      height: size.height * .3,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: AppColors.primaryColor),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.23))
          ]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: size.height * .3,
            width: size.width * .4,
            child: (data.images != null &&
                data.images!.isNotEmpty == true)
                ? FadeInImage.assetNetwork(
              placeholder:
              "assets/images/placeholder.jpg",
              fit: BoxFit.fitWidth,
              image:
              data.images?[0].image ?? "",
            )
                : Image.asset("assets/images/placeholder.jpg",
                fit: BoxFit.fitWidth),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    "${title.substring(0, title.length > 60 ? 60 : title.length - 1)}...",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${data.district}, ${data.province}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${data.price ?? 0 * 1000000000} VND",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Diện tích: ${data.area ?? 0 * 1000} m2",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ngày đăng: ${data.createDay}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
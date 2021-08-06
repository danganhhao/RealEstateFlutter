import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/constants/dimens.dart';
import 'package:real_estate/ui/web_view/web_view.dart';
import 'package:real_estate/utils/routes/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key? key,
    required this.link,
  }) : super(key: key);

  final String link;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => MyWebView(link: link))
        );
      },
      child: Container(
        margin: const EdgeInsets.all(Dimens.default_padding / 4),
        width: size.width * 0.4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/placeholder.jpg",
                fit: BoxFit.fill,
                width: size.width * 0.4,
                height: size.width * 0.21,
                image:
                "https://static.foxnews.com/static/orion/styles/img/fox-news/og/og-fox-news.png",
              ),
            ),
            Container(
              width: size.width * 0.4,
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
              child: Text(
                link.substring(0, link.length > 30 ? 30 : link.length - 1) +
                    "...",
                style: const TextStyle(
                    color: AppColors.primaryColor, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

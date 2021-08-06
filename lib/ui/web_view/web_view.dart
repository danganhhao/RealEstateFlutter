import 'package:flutter/material.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  final String link;

  const MyWebView({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('News'),
        ),
        body: WebView(
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primaryColor: AppColors.primaryColor,
          textTheme:
              Theme.of(context).textTheme.apply(bodyColor: AppColors.textColor),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:real_estate/constants/app_theme.dart';
import 'package:real_estate/ui/tab_page.dart';
import 'package:real_estate/utils/routes/routes.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Real Estate",
      initialRoute: "/",
      routes: Routes.routes,
      // theme: themeData,
      home: TabsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

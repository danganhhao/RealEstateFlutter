import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/utils/routes/routes.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("buil myApp");
    return MaterialApp(
      title: "Real Estate",
      initialRoute: "/",
      routes: Routes.routes,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("App bar"),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: FloatingActionButton(
              child: const Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.home);
                // Navigator.pushNamed(context, Routes.home);
              },
            ),
          ),
        ),
      ),
    );
  }
}

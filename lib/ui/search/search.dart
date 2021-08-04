import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => SearchScreen(),
  );

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Center(
        child: Text("AAAA"),
      ),
    );
  }
}

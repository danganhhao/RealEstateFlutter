import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/app_theme.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/user_bloc/user_bloc.dart';
import 'package:real_estate/data/network/repository/search_repository.dart';
import 'package:real_estate/data/network/repository/user_repository.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/tab_page.dart';
import 'package:real_estate/utils/routes/routes.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc(getIt<UserRepository>())),
        BlocProvider(create: (_) => SearchBloc(getIt<SearchRepository>())),
      ],
      child: MaterialApp(
        title: "Real Estate",
        initialRoute: "/",
        routes: Routes.routes,
        // theme: themeData,
        home: TabsPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

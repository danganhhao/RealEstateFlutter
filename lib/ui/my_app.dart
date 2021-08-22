import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/constants/app_theme.dart';
import 'package:real_estate/constants/colors.dart';
import 'package:real_estate/data/bloc/content_bloc/content_bloc.dart';
import 'package:real_estate/data/bloc/search_bloc/search_bloc.dart';
import 'package:real_estate/data/bloc/user_bloc/user_bloc.dart';
import 'package:real_estate/data/network/repository/content_repository.dart';
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
        BlocProvider(create: (_) => getIt<UserBloc>()),
        BlocProvider(create: (_) => getIt<SearchBloc>()),
        BlocProvider(create: (_) => getIt<ContentBloc>()),
      ],
      child: MaterialApp(
        title: "Real Estate",
        initialRoute: "/",
        routes: Routes.routes,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            primaryColor: AppColors.primaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: AppColors.textColor),
            visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

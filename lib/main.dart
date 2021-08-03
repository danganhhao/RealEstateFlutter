import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/bloc_observer/simple_bloc_observer.dart';
import 'package:real_estate/di/components/service_locator.dart';
import 'package:real_estate/ui/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    print("aaaa");
    Bloc.observer = SimpleBlocObserver();
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

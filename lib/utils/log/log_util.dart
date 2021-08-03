import 'package:flutter/foundation.dart';

class LogUtil {
  LogUtil._privateConstructor();

  static final LogUtil instance = LogUtil._privateConstructor();

  void d(Object? object) {
    if (!kReleaseMode) {
      print(object);
    }
  }
}

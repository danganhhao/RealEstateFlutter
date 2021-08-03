import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/utils/log/log_util.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    LogUtil.instance.d(event);
  }


  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LogUtil.instance.d(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    LogUtil.instance.d(error);
  }
}

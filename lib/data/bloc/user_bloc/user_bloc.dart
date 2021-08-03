import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/user_bloc/user_event.dart';
import 'package:real_estate/data/network/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, BaseState> {

  UserBloc(this._userRepository) : super(const BaseInitial());

  final UserRepository _userRepository;

  @override
  Stream<BaseState> mapEventToState(UserEvent event) async*  {
    if (event is GetUserEvent) {
      try {
        yield const BaseLoading();
        final mList = await _userRepository.getUsers();
        yield BaseLoaded(mList);
      } on Error {
        yield const BaseError(1, "message");
      }
    }
  }
}

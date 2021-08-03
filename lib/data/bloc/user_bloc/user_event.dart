import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserEvent extends UserEvent {
  @override
  List<Object>? get props => null;
}

class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(this.id);
  @override
  List<Object>? get props => null;
}
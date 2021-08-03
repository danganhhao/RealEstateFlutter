import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class BaseInitial extends BaseState {
  const BaseInitial();
  @override
  List<Object> get props => [];
}

class BaseLoading extends BaseState {
  const BaseLoading();
  @override
  List<Object>? get props => null;
}

class BaseLoaded extends BaseState {
  final Object data;
  const BaseLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class BaseError extends BaseState {
  final int code;
  final String message;
  const BaseError(this.code, this.message);
  @override
  List<Object> get props => [message, code];
}

//
// import 'package:equatable/equatable.dart';
//
// abstract class UserState extends Equatable {
//   const UserState();
// }
//
// class UserInitial extends UserState {
//   const UserInitial();
//   @override
//   List<Object> get props => [];
// }
//
// class UserLoading extends UserState {
//   const UserLoading();
//   @override
//   List<Object>? get props => null;
// }
//
// class UserLoaded extends UserState {
//   final Object covidModel;
//   const UserLoaded(this.covidModel);
//   @override
//   List<Object> get props => [covidModel];
// }
//
// class UserError extends UserState {
//   final String message;
//   const UserError(this.message);
//   @override
//   List<Object> get props => [message];
// }

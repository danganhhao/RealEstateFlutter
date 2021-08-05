import 'package:equatable/equatable.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();
}

class GetCityInfoEvent extends ContentEvent {
  @override
  List<Object>? get props => null;
}

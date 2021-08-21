import 'package:equatable/equatable.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();
}

class GetCityInfoEvent extends ContentEvent {
  @override
  List<Object>? get props => null;
}

class GetEstateTypeEvent extends ContentEvent {
  @override
  List<Object>? get props => null;
}

class GetProvinceEvent extends ContentEvent {
  @override
  List<Object>? get props => null;
}

class GetDistrictEvent extends ContentEvent {
  final proviceId;

  const GetDistrictEvent(this.proviceId);
  @override
  List<Object>? get props => null;
}

class GetWardEvent extends ContentEvent {
  final districtId;

  const GetWardEvent(this.districtId);

  @override
  List<Object>? get props => null;
}

class GetStreetEvent extends ContentEvent {
  final districtId;

  const GetStreetEvent(this.districtId);
  @override
  List<Object>? get props => null;
}
import 'package:real_estate/data/models/location/base_location.dart';

class District extends BaseLocation {
  @override
  final int id;
  @override
  final String name;
  final String prefix;

  District({required this.id, required this.name, required this.prefix}) : super(id, name);

  factory District.fromJson(dynamic json) {
    return District(id: json["id"], name: json["name"], prefix: json["prefix"]);
  }
}
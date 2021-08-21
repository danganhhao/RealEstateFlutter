import 'package:real_estate/data/models/location/base_location.dart';

class Street extends BaseLocation {
  @override
  final int id;
  @override
  final String name;
  final String prefix;

  Street({required this.id, required this.name, required this.prefix}) : super(id, name);

  factory Street.fromJson(dynamic json) {
    return Street(id: json["id"], name: json["name"], prefix: json["prefix"]);
  }
}

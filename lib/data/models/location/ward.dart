import 'package:real_estate/data/models/location/base_location.dart';

class Ward extends BaseLocation{
  @override
  final int id;
  @override
  final String name;
  final String prefix;

  Ward({required this.id, required this.name, required this.prefix}) : super(id, name);

  factory Ward.fromJson(dynamic json) {
    return Ward(id: json["id"], name: json["name"], prefix: json["prefix"]);
  }
}

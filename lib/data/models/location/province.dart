import 'package:real_estate/data/models/location/base_location.dart';

class Province extends BaseLocation{
  @override
  final int id;
  @override
  final String name;
  final String code;

  Province({required this.id, required this.name, required this.code}) : super(id, name);

  factory Province.fromJson(dynamic json) {
    return Province(id: json["id"], name: json["name"], code: json["code"]);
  }

  @override
  String toString() {
    return "{\"id\": $id, \"name\": $name, \"code\": $code }";
  }
}

class EstateType {
  final int id;
  final String name;

  EstateType({required this.id, required this.name});

  factory EstateType.fromJson(dynamic json) {
    return EstateType(id: json["id"], name: json["name"]);
  }

  @override
  String toString() {
    return "{\"id\": $id, \"name\": $name }";
  }
}
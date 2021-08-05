class CityInfo {
  List<CityItem>? items;

  CityInfo({this.items});

  factory CityInfo.fromJson(List<dynamic> json) {
    List<CityItem> items = <CityItem>[];
    items = json.map((city) => CityItem.fromJson(city)).toList();
    return CityInfo(items: items);
  }
}

class CityItem {
  int? id;
  String? name;
  int? totalEstate;
  List<String>? images;

  CityItem({this.id, this.name, this.totalEstate, this.images});

  factory CityItem.fromJson(dynamic json) {
    List<String>? images =
        (json["images"] as List).map((e) => e as String).toList();
    return CityItem(
        id: json["id"] as int?,
        name: json["name"] as String?,
        totalEstate: json["total_estate"] as int?,
        images: images);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "total_estate": totalEstate,
        "images": images,
      };
}

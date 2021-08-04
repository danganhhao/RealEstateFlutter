class Post {
  String? currentPage;
  String? totalPage;
  List<PostItem>? result;

  Post({this.currentPage, this.totalPage, this.result});

  factory Post.fromMap(Map<String, dynamic> json) {
    if (json["result"] != null) {
      var postObject = json["result"] as List;
      List<PostItem> _postItem =
          postObject.map((postJson) => PostItem.fromJson(postJson)).toList();

      return Post(
          currentPage: json["current_page"],
          totalPage: json["total_page"],
          result: _postItem);
    } else {
      return Post(
          currentPage: json["current_page"], totalPage: json["total_page"]);
    }
  }

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "total_page": totalPage,
        "result": result,
      };
}

class PostItem {
  int? id;
  String? title;
  String? province;
  String? district;
  String? contact;
  double? area;
  int? price;
  String? createDay;
  double? lat;
  double? lng;
  Project? project;
  List<PostImage>? images;

  PostItem(
      {this.id,
      this.title,
      this.province,
      this.district,
      this.contact,
      this.area,
      this.price,
      this.createDay,
      this.lat,
      this.lng,
      this.project,
      this.images});

  factory PostItem.fromJson(dynamic json) {
    List<PostImage>? _postImage;
    Project? _postProject;
    if (json["images"] != null && json["project"] != null) {
      var postObject = json["images"] as List;
      _postImage =
          postObject.map((postImage) => PostImage.fromJson(postImage)).toList();
      _postProject = Project.fromJson(json["project"]);
    } else if (json["images"] != null) {
      var postObject = json["images"] as List;
      _postImage =
          postObject.map((postImage) => PostImage.fromJson(postImage)).toList();
    } else if (json["project"] != null) {
      _postProject = Project.fromJson(json["project"]);
    }

    return PostItem(
        id: json["id"] as int?,
        title: json["title"] as String?,
        province: json["province"] as String?,
        district: json["district"] as String?,
        contact: json["contact"] as String?,
        area: json["area"] as double?,
        price: json["price"] as int?,
        createDay: json["created_day"] as String?,
        lat: json["lat"] as double?,
        lng: json["lng"] as double?,
        project: _postProject,
        images: _postImage);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "province": province,
        "district": district,
        "contact": contact,
        "area": area,
        "price": price,
        "created_day": createDay,
        "lat": lat,
        "lng": lng,
        "project": project,
        "images": images,
      };
}

class Project {
  int? id;
  String? name;
  double? lat;
  double? lng;

  Project({this.id, this.name, this.lat, this.lng});

  factory Project.fromMap(Map<String, dynamic> json) => Project(
      id: json["id"], name: json["name"], lat: json["lat"], lng: json["lng"]);

  factory Project.fromJson(dynamic json) {
    if (json != "") {
      return Project(
          id: json["id"] as int?,
          name: json["name"] as String?,
          lat: json["lat"] as double?,
          lng: json["lng"] as double);
    } else {
      return Project();
    }
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
      };
}

class PostImage {
  int? id;
  String? image;

  PostImage({this.id, this.image});

  factory PostImage.fromMap(Map<String, dynamic> json) =>
      PostImage(id: json["id"], image: json["image"]);

  factory PostImage.fromJson(dynamic json) {
    return PostImage(id: json["id"] as int?, image: json["image"] as String?);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
      };
}

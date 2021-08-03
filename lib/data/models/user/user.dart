class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? gender;
  String? birthday;
  String? address;
  String? avatar;
  String? phoneNumber;
  String? identifyNumber;
  bool? isAgency;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.gender,
      this.birthday,
      this.address,
      this.avatar,
      this.phoneNumber,
      this.identifyNumber,
      this.isAgency});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      gender: json["gender"],
      birthday: json["birthday"],
      address: json["address"],
      avatar: json["avatar"],
      phoneNumber: json["phoneNumber"],
      identifyNumber: json["identifyNumber"],
      isAgency: json["isAgency"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "gender": gender,
        "birthday": birthday,
        "address": address,
        "avatar": avatar,
        "phoneNumber": phoneNumber,
        "identifyNumber": identifyNumber,
        "isAgency": isAgency
      };
}

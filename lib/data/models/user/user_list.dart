import 'package:real_estate/data/models/user/user.dart';

class UserList {
  final List<User>? users;

  UserList({this.users});

  factory UserList.fromJson(List<dynamic> json) {
    List<User> users = <User>[];
    users = json.map((user) => User.fromMap(user)).toList();
    return UserList(users: users);
  }
}

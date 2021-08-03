import 'package:real_estate/data/models/user/user_list.dart';
import 'package:real_estate/data/network/api/users/user_api.dart';
import 'package:real_estate/data/sharedpref/shared_preference_helper.dart';

class UserRepository {
  // data source object
  // final PostDataSource _postDataSource;

  // api objects
  final UserApi _userApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserRepository(this._userApi, this._sharedPrefsHelper);

  Future<UserList> getUsers() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userApi.getUsers().then((userList) {
      // userList.posts?.forEach((post) {
      //   _postDataSource.insert(post);
      // });

      return userList;
    }).catchError((error) => throw error);
  }
}
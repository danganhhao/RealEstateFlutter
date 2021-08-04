import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/network/api/search_engine/search_api.dart';
import 'package:real_estate/data/sharedpref/shared_preference_helper.dart';

class SearchRepository {
  // api objects
  final SearchApi _searchApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  SearchRepository(this._searchApi, this._sharedPrefsHelper);

  Future<Post> getPosts() async {
    return await _searchApi.getPosts().then((userList) {
      return userList;
    }).catchError((error) => throw error);
  }
}

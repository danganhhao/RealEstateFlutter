import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/network/constants/endpoints.dart';
import 'package:real_estate/data/network/dio_client.dart';

class SearchApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  SearchApi(this._dioClient);

  // Returns list of post in response
  Future<Post> getPosts() async {
    try {
      final res = await _dioClient.post(Endpoints.getPosts);
      return Post.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

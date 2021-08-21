import 'package:dio/dio.dart';
import 'package:real_estate/data/models/search_engine/entity/post.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';
import 'package:real_estate/data/network/constants/endpoints.dart';
import 'package:real_estate/data/network/dio_client.dart';
import 'package:real_estate/utils/log/log_util.dart';

class SearchApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  SearchApi(this._dioClient);

  // Returns list of post in response
  Future<Post> getPosts(SearchRequest data, int page) async {
    try {
      var formData = FormData.fromMap({
        'keyword': data.keyword,
        'province': data.province,
        'district': data.district,
        'ward': data.ward,
        'street': data.street,
        'estate_type': data.estateType,
        'sort': data.sort,
        'filter_max_price': data.filterMaxPrice,
        'filter_min_price': data.filterMinPrice,
        'filter_area': data.filterArea,
        'filter_number_of_room': data.filterNumberOfRoom,
        'filter_post_time': data.filterPostTime,
        'device_id': data.deviceId,
      });
      final res = await _dioClient.post("${Endpoints.getPosts}$page", data: formData);
      return Post.fromMap(res);
    } catch (e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }
}

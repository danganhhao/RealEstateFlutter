import 'package:real_estate/data/models/user/user_list.dart';
import 'package:real_estate/data/network/constants/endpoints.dart';
import 'package:real_estate/data/network/dio_client.dart';
import 'package:real_estate/data/network/exceptions/network_exceptions.dart';
import 'package:real_estate/data/network/rest_client.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserApi(this._dioClient, this._restClient);

  // Returns list of post in response
  Future<UserList> getUsers() async {
    try {
      final res = await _dioClient.get(Endpoints.getUsers);
      return UserList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

/// sample api call with default rest client
//  Future<UserList> getUsers() {
//
//    return _restClient
//        .get(Endpoints.getUsers)
//        .then((dynamic res) => UserList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}

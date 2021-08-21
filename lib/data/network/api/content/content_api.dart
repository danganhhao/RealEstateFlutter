import 'package:real_estate/data/models/city_info/city_info.dart';
import 'package:real_estate/data/models/estate_type/estate_type.dart';
import 'package:real_estate/data/models/location/district.dart';
import 'package:real_estate/data/models/location/province.dart';
import 'package:real_estate/data/models/location/street.dart';
import 'package:real_estate/data/models/location/ward.dart';
import 'package:real_estate/data/network/constants/endpoints.dart';
import 'package:real_estate/data/network/dio_client.dart';
import 'package:real_estate/utils/log/log_util.dart';

class ContentApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ContentApi(this._dioClient);

  // Returns list of post in response
  Future<CityInfo> getCityInfo() async {
    try {
      final res = await _dioClient.get(Endpoints.getCityInfo);
      return CityInfo.fromJson(res);
    } catch (e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }
  
  Future<List<EstateType>> getEstateType() async {
    try {
      final res = await _dioClient.get(Endpoints.getEstateType);
      return (res as List<dynamic>).map((json) => EstateType.fromJson(json)).toList();
    } catch(e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }

  Future<List<Province>> getProvinces() async {
    try {
      final res = await _dioClient.get(Endpoints.getProvince);
      return (res as List<dynamic>).map((json) => Province.fromJson(json)).toList();
    } catch(e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }

  Future<List<District>> getDistrict(String provinceId) async {
    try {
      final res = await _dioClient.get("${Endpoints.getDistrict}$provinceId");
      return (res as List<dynamic>).map((json) => District.fromJson(json)).toList();
    } catch(e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }

  Future<List<Ward>> getWard(String districtId) async {
    try {
      final res = await _dioClient.get("${Endpoints.getWard}$districtId");
      return (res as List<dynamic>).map((json) => Ward.fromJson(json)).toList();
    } catch(e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }

  Future<List<Street>> getStreet(String districtId) async {
    try {
      final res = await _dioClient.get("${Endpoints.getStreet}$districtId");
      return (res as List<dynamic>).map((json) => Street.fromJson(json)).toList();
    } catch(e) {
      LogUtil.instance.d(e);
      rethrow;
    }
  }


}

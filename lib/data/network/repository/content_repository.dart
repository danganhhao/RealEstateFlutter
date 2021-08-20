import 'package:real_estate/data/models/city_info/city_info.dart';
import 'package:real_estate/data/models/estate_type/estate_type.dart';
import 'package:real_estate/data/network/api/content/content_api.dart';
import 'package:real_estate/data/sharedpref/shared_preference_helper.dart';

class ContentRepository {
  // api objects
  final ContentApi _contentApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  ContentRepository(this._contentApi, this._sharedPrefsHelper);

  Future<CityInfo> getCityInfo() async {
    return await _contentApi.getCityInfo().then((cityInfo) {
      return cityInfo;
    }).catchError((error) => throw error);
  }

  Future<List<EstateType>> getEstateType() async {
    return await _contentApi.getEstateType().then((estateType) {
      return estateType;
    }).catchError((error) => throw error);
  }
}

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://danganhhaotest.pythonanywhere.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectionTimeout
  static const int connectionTimeout = 30000;

  static const String getUsers = "$baseUrl/api/user";
  static const String getPosts = "$baseUrl/api/search/?page=";
  static const String getCityInfo = "$baseUrl/api/cityinfo/";
  static const String getEstateType = "$baseUrl/api/estatetype/";
  static const String getProvince = "$baseUrl/api/s/province/";
  static const String getDistrict = "$baseUrl/api/s/district/";
  static const String getWard = "$baseUrl/api/s/ward/";
  static const String getStreet = "$baseUrl/api/s/street/";

}

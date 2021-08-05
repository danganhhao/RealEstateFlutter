class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://danganhhaotest.pythonanywhere.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectionTimeout
  static const int connectionTimeout = 30000;

  static const String getUsers = "$baseUrl/api/user";
  static const String getPosts = "$baseUrl/api/search/?page=1";
  static const String getCityInfo = "$baseUrl/api/cityinfo/";

}

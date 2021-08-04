class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://danganhhaotest.pythonanywhere.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectionTimeout
  static const int connectionTimeout = 30000;

  static const String getUsers = "$baseUrl/api/user";

}
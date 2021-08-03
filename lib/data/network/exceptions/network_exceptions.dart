class NetworkException implements Exception {
  int? code;
  String? message;

  NetworkException({this.code, this.message});
}

class AuthException extends NetworkException {
  AuthException({code, message}) : super(code: code, message: message);
}

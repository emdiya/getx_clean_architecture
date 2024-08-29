class BaseUrl {
  static String get dev => "https://api.escuelajs.co/api/v1";
  static String get pre => "https://pre.com";
  static String get pro => "https://pro.com";
  BaseUrl._();
}

class BasicAuth {
  static BasicAuth? _instance;

  factory BasicAuth() => _instance ??= BasicAuth._();

  BasicAuth._();
  String get password => "utshrmobile";
  //field
  String get username => "utshrmobile";
}

class Endpoints {
  static const int receiveTimeout = 6 * 1000;

  // connectTimeout
  static const int connectionTimeout = 8 * 1000;

  static const String products = '/products';
  static const String refreshToken = '/refreshToken';
  Endpoints._();
  static String productDetail(int? id) =>
      "/products/$id";
}

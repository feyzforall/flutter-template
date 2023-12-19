/// `LocalDataKeys` sınıfı, uygulamada lokal depolama için kullanılan anahtarları içerir.
class LocalDataKeys {
  // Singleton
  static final LocalDataKeys _instance = LocalDataKeys._internal();

  factory LocalDataKeys() {
    return _instance;
  }

  LocalDataKeys._internal();

  // Box Names
  static const String token = 'token';

  // Value Names
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String authStatus = 'auth_status';
}

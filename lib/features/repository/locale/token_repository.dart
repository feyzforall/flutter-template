import 'package:hive/hive.dart';

import '../../../product/constants/local_data_keys.dart';

/// `TokenRepository` sınıfı, kullanıcının oturum açma durumunu kontrol etmek
/// ve servisten alınan token'ı lokalde saklamak için kullanılır.
class TokenRepository {
  static final _tokenBox = Hive.box(LocalDataKeys.token);

  /// Servisten alınan access token'ı lokale kaydeder.
  ///
  /// [token]: Saklanacak token değeri.
  static void saveAccessToken(String token) {
    _tokenBox.put(LocalDataKeys.accessToken, token);
  }

  /// Servisten alınan refresh token'ı lokale kaydeder.
  ///
  /// [token]: Saklanacak token değeri.
  static void saveRefreshToken(String token) {
    _tokenBox.put(LocalDataKeys.refreshToken, token);
  }

  /// Kullanıcın login durumunu lokale kaydeder.
  ///
  /// [status] : Saklanacak status değer.
  static void saveAuthStatus(bool status) {
    _tokenBox.put(LocalDataKeys.authStatus, status);
  }

  /// Lokalde kayıtlı olan access token'ı getirir.
  ///
  /// [return]: Saklanan token değeri veya null (eğer bulunamazsa).
  static String? getAccessToken() {
    final accessToken = _tokenBox.get(LocalDataKeys.accessToken);
    return accessToken;
  }

  /// Lokalde kayıtlı olan refresh token'ı getirir.
  ///
  /// [return]: Saklanan token değeri veya null (eğer bulunamazsa).
  static String? getRefreshToken() {
    final refreshToken = _tokenBox.get(LocalDataKeys.refreshToken);
    return refreshToken;
  }

  /// Lokalde kayıtlı olan auth status'u getirir.
  ///
  /// true => kullanıcı giriş yapmış.
  /// false => kullanıcı giriş yapmamış.
  static bool getAuthStatus() {
    final status = _tokenBox.get(LocalDataKeys.authStatus);
    return status ?? false;
  }

  static void clear() {
    _tokenBox.clear();
  }
}

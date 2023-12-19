import 'dart:async';

import 'package:dio/dio.dart';

import '../../../product/constants/endpoints.dart';
import '../../model/token.dart';
import '../locale/token_repository.dart';

// Kullanıcı adı veya şifre hatalı olduğu zaman fırlatılacak hata.
class AuthorizationException implements Exception {}

// Giriş işlemi sırasında oluşacak herhangi bir hatada fırlatılacak hata.
class GeneralException implements Exception {}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// `AuthRepository` sınıfı, kullanıcı giriş işlemlerini yönetir ve
/// servisten alınan token ve refresh token'ı lokalde saklar.
class AuthenticationRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    ),
  );

  // login ve refreshToken isteklerinde kullanılan url.

  /// Kullanıcı giriş işlemini gerçekleştirir ve gelen token ve refresh token'ı lokalde saklar.
  ///
  /// [username]: Kullanıcı adı.
  /// [password]: Kullanıcı şifresi.
  Future<Token> login(String username, String password) async {
    try {
      final response = await dio.post(
        Endpoints.token,
        data: {
          'grant_type': 'password',
          'username': username,
          'password': password,
        },
      );

      final token = Token.fromJson(response.data);

      // Token ve refresh token'ı lokalde saklama.
      TokenRepository.saveAccessToken(token.accessToken);
      TokenRepository.saveRefreshToken(token.refreshToken);
      TokenRepository.saveAuthStatus(true);

      return token;
    } on DioException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  /// Kullanıcının token süresi bittiğinde yeni token alır ve gelen token
  /// ve refresh token'ı lokalde saklar
  ///
  /// [refreshToken]: Refresh Token
  Future<Token> refreshToken(String? refreshToken) async {
    final response = await dio.post(
      Endpoints.token,
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      },
    );

    // !TODO : Tam olarak böyle mi olacak emin değilim. Buraya bakmak lazım.
    // Error Handling
    if (response.statusCode == 200) {
      final token = Token.fromJson(response.data);

      // Token ve refresh token'ı lokalde saklama.
      TokenRepository.saveAccessToken(token.accessToken);
      TokenRepository.saveRefreshToken(token.refreshToken);

      return token;
    } else {
      throw Exception();
    }
  }

  void logOut() {
    TokenRepository.clear();
  }
}

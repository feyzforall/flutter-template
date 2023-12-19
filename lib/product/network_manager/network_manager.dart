import 'package:dio/dio.dart';

import '../../features/repository/locale/token_repository.dart';
import '../../features/repository/remote/auth_repository.dart';
import '../constants/endpoints.dart';

class NetworkManager {
  final Dio dio;

  NetworkManager(this.dio) {
    _initializeDio();
  }

  void _initializeDio() {
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final token = TokenRepository.getAccessToken();
            options.headers = {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            };
            return handler.next(options);
          },
          onError: (e, handler) async {
            if (e.response?.statusCode == 401) {
              final refreshToken = TokenRepository.getRefreshToken();
              final accessToken = await AuthenticationRepository().refreshToken(refreshToken);

              e.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

              return handler.resolve(
                await dio.fetch(
                  e.requestOptions,
                ),
              );
            }
            return handler.next(e);
          },
        ),
      )
      ..interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
      ))
      ..options.headers['Content-Type'] = 'application/json';
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response<dynamic> response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response<dynamic> response = await dio.post(
        path,
        data: data,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      final Response<dynamic> response = await dio.delete(
        path,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}

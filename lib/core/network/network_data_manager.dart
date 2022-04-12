import 'package:dio/dio.dart';

import '../constants/endpoints.dart';
import 'dio_exceptions.dart';
import 'dio_interceptors.dart';

class NetworkDataManager {
  final Dio dio;

  NetworkDataManager(this.dio) {
    dio.options.baseUrl = Endpoints.baseUrl;
    dio.interceptors.add(CustomInterceptors());
    // dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  Future<Response> get(String path, {queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioError catch (err) {
      throw handleException(err);
    }
  }

  Future<Response> post(String path, {data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioError catch (err) {
      throw handleException(err);
    }
  }
}

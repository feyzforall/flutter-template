import 'package:dio/dio.dart';

// TODO
class CustomInterceptors extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    //print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/enum/exception_type.dart';
import 'exceptions.dart';

ServerException handleException(error) {
  if (error is Exception) {
    try {
      ServerException exception = ServerException(ExceptionType.unknownError);
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            exception = ServerException(ExceptionType.requestCancelled);
            break;
          case DioErrorType.connectTimeout:
            exception = ServerException(ExceptionType.requestTimeout);
            break;
          case DioErrorType.receiveTimeout:
            exception = ServerException(ExceptionType.timeout);
            break;
          case DioErrorType.response:
            switch (error.response!.statusCode) {
              case 400:
                exception = ServerException(ExceptionType.badRequest);
                break;
              case 401:
                exception = ServerException(ExceptionType.unauthorisedRequest);
                break;
              case 403:
                exception = ServerException(ExceptionType.unauthorisedRequest);
                break;
              case 404:
                exception = ServerException(ExceptionType.notFound);
                break;
              case 408:
                exception = ServerException(ExceptionType.requestTimeout);
                break;
              case 500:
                exception = ServerException(ExceptionType.internalServerError);
                break;
              case 503:
                exception = ServerException(ExceptionType.serviceUnavailable);
                break;
              case 488:
                exception = ServerException(ExceptionType.unauthorizedUser);
                break;
              case 409:
                exception = ServerException(ExceptionType.conflict);
                break;
              default:
                exception = ServerException(ExceptionType.unknownError);
            }
            break;
          case DioErrorType.sendTimeout:
            exception = ServerException(ExceptionType.timeout);
            break;
          case DioErrorType.other:
            if (error.toString().contains('SocketException')) {
              exception = ServerException(ExceptionType.noInternetConnection);
              break;
            } else {
              exception = ServerException(ExceptionType.unknownError);
              break;
            }
        }
      } else if (error is SocketException) {
        exception = ServerException(ExceptionType.noInternetConnection);
      } else {
        exception = ServerException(ExceptionType.unknownError);
      }
      return exception;
    } on FormatException catch (_) {
      return ServerException(ExceptionType.formatException);
    } catch (_) {
      return ServerException(ExceptionType.unknownError);
    }
  } else {
    return ServerException(ExceptionType.unknownError);
  }
}

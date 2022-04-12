import '../constants/enum/exception_type.dart';

class ServerException implements Exception {
  final ExceptionType exceptionType;

  ServerException(this.exceptionType);
}

class CacheException implements Exception {}

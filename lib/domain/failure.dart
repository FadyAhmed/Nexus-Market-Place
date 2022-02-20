import 'package:dio/dio.dart';

class Failure {
  String message;

  Failure(this.message);
}

extension GetFailure on DioError {
  Failure get failure {
    switch (type) {
      case DioErrorType.connectTimeout:
        return Failure('connection timed out');
      case DioErrorType.sendTimeout:
        return Failure('sending data timed out');
      case DioErrorType.receiveTimeout:
        return Failure('receiving data timed out');
      case DioErrorType.cancel:
        return Failure('request was cancelled');
      case DioErrorType.other:
        return Failure('unknown error');
      case DioErrorType.response:
        switch (response?.statusCode) {
          case 401:
            return Failure('unauthenticated');
          case 403:
            return Failure('unauthorized');
          case 404:
            return Failure('not found');
          default:
            return Failure('unknown error');
        }
    }
  }
}

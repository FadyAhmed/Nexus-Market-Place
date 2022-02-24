import 'package:dio/dio.dart';

class Failure {
  static List<String> serverErrorMessages = [
    'item already exists in your store',
    'invalid amount',
    'amount is larger than the available',
    "item doesn't exist",
  ];

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
        String errorMessage = response?.data['status'];
        if (Failure.serverErrorMessages.contains(errorMessage)) {
          return Failure(errorMessage);
        }
        switch (response?.statusCode) {
          case 400:
            return Failure('unknown error');
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

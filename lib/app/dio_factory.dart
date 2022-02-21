import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ds_market_place/globals.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio get getDio {
  Dio dio = Dio();
  const int timeOut = 60 * 1000;
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  dio.options = BaseOptions(
    connectTimeout: timeOut,
    receiveTimeout: timeOut,
    headers: headers,
  );

  // dio.interceptors.add(
  //   PrettyDioLogger(
  //       // requestHeader: true,
  //       // requestBody: true,
  //       // responseHeader: true,
  //   ),
  // );

  return dio;
}

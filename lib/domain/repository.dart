import 'package:dartz/dartz.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:dio/dio.dart';
import 'package:ds_market_place/globals.dart';

class Repository {
  RestClient restClient;

  Repository(this.restClient);

  Future<Either<Failure, void>> signIn(LoginRequest loginRequest) async {
    try {
      LoginResponse response = await restClient.signIn(loginRequest);

      token = response.token;
      print(token);

      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }
}

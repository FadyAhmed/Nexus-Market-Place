import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://nexus-market.herokuapp.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/api/users/login')
  Future<LoginResponse> signIn(@Body() LoginRequest loginRequest);
}

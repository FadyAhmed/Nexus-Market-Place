import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/authentication_model.dart';

class AuthenticationWebService {
  http.Client client;

  AuthenticationWebService({required this.client});

  Future<AuthenticationModel> signIn(String email, String password) async {
    http.Response response =
        await client.get(Uri.parse(RoutesConstants.signIn));
    if (response.statusCode != 200) throw ServerException();
    return AuthenticationModel.fromJson(jsonDecode(response.body));
  }

  Future<AuthenticationModel> signUp(String email, String password) async {
    http.Response response =
        await client.get(Uri.parse(RoutesConstants.signUp));
    if (response.statusCode != 200) throw ServerException();
    return AuthenticationModel.fromJson(jsonDecode(response.body));
  }
}

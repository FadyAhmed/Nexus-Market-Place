import 'dart:convert';

import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/signup.dart';
import 'package:http/http.dart' as http;
import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/authentication_model.dart';

class AuthenticationWebService {
  http.Client client;

  AuthenticationWebService({required this.client});

  Future<String> signIn(Login loginData) async {
    http.Response response =
        await client.post(
      Uri.parse(RoutesConstants.signIn),
      body: jsonEncode(loginData.toJson()),
      headers: {'Content-type': 'application/json'},
    );
    var body = jsonDecode(response.body);
    if (!body['success']) {
      print('authentication: login: error');
      throw ServerException(generateErrorMessage(body));
    }
    return body['token'];
  }

  Future<bool> signUp(Signup signupData) async {
    http.Response response = await client.post(
      Uri.parse(RoutesConstants.signUp),
      body: jsonEncode(signupData.toJson()),
      headers: {'Content-type': 'application/json'},
    );
    var body = jsonDecode(response.body);
    if (!body['success']) {
      print('authentication: signup: error');
      throw ServerException(generateErrorMessage(body));
    }

    print('authentication: signup: user signed up successfully');
    return true;
  }
}

import 'dart:convert';

import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/signup.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:http/http.dart' as http;
import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/authentication_model.dart';
import 'package:ds_market_place/globals.dart' as globals;

class AuthenticationWebService {
  http.Client client;
  // dependent on stores web service just to get the store name of current logged in user
  StoresWebService storesWebService = StoresWebService();

  AuthenticationWebService({required this.client});

  Future<void> signIn(Login loginData) async {
    http.Response response = await client.post(
      Uri.parse(RoutesConstants.signIn),
      body: jsonEncode(loginData.toJson()),
      headers: {'Content-type': 'application/json'},
    );
    var body = jsonDecode(response.body);
    if (!body['success']) {
      print('authentication: login: error');
      throw ServerException(generateErrorMessage(body));
    }
    globals.token = body['token'];
    setAdminStatus(response, loginData);
    setStore(response, storesWebService);
    return;
  }

  Future<bool> signUp(Signup signupData) async {
    http.Response response = await client.post(
      Uri.parse(RoutesConstants.signUp),
      body: jsonEncode(signupData.toJson()),
      headers: {'Content-type': 'application/json'},
    );
    var body = jsonDecode(response.body);
    if (!body['success']) {
      throw ServerException(generateErrorMessage(body));
    }

    return true;
  }
}

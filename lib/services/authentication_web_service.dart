import 'dart:convert';

import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/signup.dart';
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
    // if (response.statusCode != 200) throw ServerException();
    return AuthenticationModel.fromJson(jsonDecode(response.body));
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

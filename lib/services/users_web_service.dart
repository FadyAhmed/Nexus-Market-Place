import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:ds_market_place/globals.dart' as globals;

class UsersWebService {
  Future<Profile> getMyProfile() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getMyProfile),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    if (!body['success']) throw ServerException(generateErrorMessage(body));
    return Profile.fromJson(body['user']);
  }
}

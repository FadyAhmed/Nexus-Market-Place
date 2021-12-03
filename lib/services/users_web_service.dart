import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/add_balance_request.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:ds_market_place/globals.dart' as globals;

class UsersWebService {
  Future<Profile> getMyProfile() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getMyProfile),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return Profile.fromJson(body['user']);
  }

  Future<List<User>> getAllUsers() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getAllUsers),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return (body['users'] as List).map((user) => User.fromJson(user)).toList();
  }

  Future<void> addBalance(AddBalanceRequest addBalanceRequest) async {
    var response = await http.put(
      Uri.parse(RoutesConstants.addBalance),
      body: jsonEncode(addBalanceRequest.toJson()),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
  }

  Future<void> removeBalance(AddBalanceRequest addBalanceRequest) async {
    var response = await http.put(
      Uri.parse(RoutesConstants.removeBalance),
      body: jsonEncode(addBalanceRequest.toJson()),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
  }
}

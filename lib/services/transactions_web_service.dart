import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:ds_market_place/globals.dart' as globals;

class TransactionsWebService {
  Future<List<Transaction>> getSoldItems() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getSoldItems),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return (body['transactions'] as List)
        .map((transaction) =>
            Transaction.fromJson(transaction))
        .toList();
  }

  Future<List<Transaction>> getPurchasedItems() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getPurchasedItems),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return (body['transactions'] as List)
        .map((transaction) =>
            Transaction.fromJson(transaction))
        .toList();
  }

  Future<List<Transaction>> getAllTransactions() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getAllTransactions),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return (body['transactions'] as List)
        .map((transaction) => Transaction.fromJson(transaction))
        .toList();
  }
}

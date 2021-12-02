import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:http/http.dart' as http;

class StoresWebService {
  Future<List<StoreItem>> getAllItemsFromMyStore() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getAllItemsFromMyStore),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
      },
    );
    checkResponse(response);

    Map<String, dynamic> body = jsonDecode(response.body);
    return (body['items'] as List)
        .map((json) => StoreItem.fromJson(json))
        .toList();
  }

  Future<StoreItem> getItemFromMyStore(String id) async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getItemFromMyStore(id)),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);

    Map<String, dynamic> body = jsonDecode(response.body);
    return StoreItem.fromJson(body['item']);
  }

  Future<String> addInventoryItemToMyStore({
    required String id,
    required double price,
    required int amount,
  }) async {
    var response = await http.post(
      Uri.parse(RoutesConstants.addInventoryItemToMyStore(id)),
      body: jsonEncode({'amount': amount, 'price': price}),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
    var body = jsonDecode(response.body);
    return body['id'];
  }

  Future<void> removeItemFromMyStore(String id) async {
    var response = await http.delete(
      Uri.parse(RoutesConstants.removeItemFromMyStore(id)),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
  }
}

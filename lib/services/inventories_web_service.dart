import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:http/http.dart' as http;

class InventoriesWebService {
  Future<void> addItem(InventoryItem item) async {
    var response = await http.post(
      Uri.parse(RoutesConstants.addItemToInventory),
      body: jsonEncode(item.toJson()),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
  }

  Future<List<InventoryItem>> getAllItems() async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getAllInventoryItems),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
      },
    );
    checkResponse(response);

    Map<String, dynamic> body = jsonDecode(response.body);
    return (body['items'] as List)
        .map((json) => InventoryItem.fromJson(json))
        .toList();
  }

  Future<InventoryItem> getItemById(String id) async {
    var response = await http.get(
      Uri.parse(RoutesConstants.getInventoryItemById(id)),
      headers: {'Authorization': 'Bearer ${globals.token}'},
    );
    checkResponse(response);

    Map<String, dynamic> body = jsonDecode(response.body);
    return InventoryItem.fromJson(body['item']);
  }

  Future<void> editItem(InventoryItem item) async {
    assert(item.id != null);
    var response = await http.put(
      Uri.parse(RoutesConstants.editInventoryItem(item.id!)),
      body: jsonEncode(item.toJson()),
      headers: {
        'Authorization': 'Bearer ${globals.token}',
        'Content-Type': 'application/json',
      },
    );
    checkResponse(response);
  }
}

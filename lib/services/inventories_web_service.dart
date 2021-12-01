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
}

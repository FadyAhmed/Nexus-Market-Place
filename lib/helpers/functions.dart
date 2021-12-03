import 'dart:convert';

import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> showMessageDialogue(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}

void checkResponse(http.Response response) {
  Map<String, dynamic> body = jsonDecode(response.body);
  if (!body['success']) throw ServerException(generateErrorMessage(body));
}

void setAdminStatus(http.Response response, Login loginData) {
  var body = jsonDecode(response.body);
  if (body['admin'] != null) {
    globals.admin = body['admin'];
    return;
  }
  List<String> adminUsernames = [
    'user1',
  ];
  globals.admin = adminUsernames.contains(loginData.username);
}

void setStore(http.Response response, StoresWebService storesWebService) async {
  var body = jsonDecode(response.body);
  if (body['storeName'] != null) {
    globals.storeName = body['storeName'];
    return;
  }
  List<StoreItem> items = await storesWebService.getAllItemsFromMyStore();
  globals.storeName = items.first.storeName;
}

String generateErrorMessage(Map<String, dynamic> badRequest) {
  if (badRequest['status'] == 'process failed') {
    Map<String, dynamic> err = badRequest['err'] as Map<String, dynamic>;
    switch (err['name']) {
      case 'UserExistsError':
        return err['message'] as String;
      default:
        return 'Unknown server error';
    }
  }
  switch (badRequest['status']) {
    case 'storeName already exists':
      return 'Store name already exists.';
    case 'token verification failed':
      return 'Token verification failed. Couldn\'t establish a session.';
    case "you can’t buy this item":
      return 'You can\'t buy this item. Insufficient balance';
    default:
      return badRequest['status'] as String;
  }
}

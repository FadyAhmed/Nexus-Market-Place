import 'dart:convert';

import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/add_balance_request.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/home_page_screen.dart';
import 'package:ds_market_place/services/inventories_web_service.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:ds_market_place/services/transactions_web_service.dart';
import 'package:ds_market_place/services/users_web_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TestingButton extends StatelessWidget {
  const TestingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var response = await http.get(Uri.parse(
            'https://images.unspasdadasdlash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80'));
        print(response.statusCode);
      },
      child: Text('Testing Button'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}

class LoginAsUser1Button extends StatelessWidget {
  const LoginAsUser1Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          Login loginData = Login(username: 'user1', password: '123');
          await Provider.of<AuthenticationProvider>(context, listen: false)
              .signIn(loginData);
          showMessageDialogue(context, 'Logged in successfully as user 1');
        } on ServerException catch (e) {
          showMessageDialogue(context, e.message);
        }
      },
      child: Text('Login as user1'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}

class GoToMarketPlace extends StatelessWidget {
  const GoToMarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MarketHomePage()),
            (Route<dynamic> route) => false);
      },
      child: Text('Go To Marketplace'),
      style: ElevatedButton.styleFrom(primary: Colors.purple),
    );
  }
}

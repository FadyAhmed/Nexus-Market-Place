import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/add_balance_request.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/authentication_provider.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/home_page_screen.dart';
import 'package:ds_market_place/services/inventories_web_service.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:ds_market_place/services/users_web_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestingButton extends StatelessWidget {
  const TestingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // var item = StoreItem(
        //   id: '61a8b5c21bf9c65143eb0963',
        //   name: 'item2.5',
        //   price: 2.95,
        //   amount: 2,
        //   imageLink: 'link2.5',
        //   description: 'desc2.5',
        //   state: StoreItemState.owned,
        //   storeId: 'storeId',
        //   storeName: 'storeName',
        // );
        print(await Provider.of<StoresProvider>(context, listen: false)
            .searchAllStores('item'));
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

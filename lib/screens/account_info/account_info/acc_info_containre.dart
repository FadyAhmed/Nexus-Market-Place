import 'package:ds_market_place/screens/account_info/account_info/on_sale_items.dart';
import 'package:ds_market_place/screens/account_info/account_info/purshaced_items.dart';
import 'package:ds_market_place/screens/account_info/account_info/sold_items.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:flutter/material.dart';

class AccountInfoContainer extends StatefulWidget {
  const AccountInfoContainer({Key? key}) : super(key: key);

  @override
  _AccountInfoContainerState createState() => _AccountInfoContainerState();
}

class _AccountInfoContainerState extends State<AccountInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Account Info"),
            bottom: const TabBar(
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2.6,
                tabs: [
                  Tab(child: Text("Sold Items", textAlign: TextAlign.center)),
                  Tab(
                      child:
                          Text("Purshced Items", textAlign: TextAlign.center)),
                  Tab(child: Text("On Sale Items", textAlign: TextAlign.center))
                ]),
          ),
          body: const TabBarView(children: [
            Tab(child: SoldItemsScreen()),
            Tab(child: PurchasedItemsScreen()),
            Tab(child: OnSaleItemsScreen())
          ])),
    );
  }
}

import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
import 'package:flutter/material.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({Key? key, required this.storeName})
      : super(key: key);
  final String storeName;
  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.storeName),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
              showActions: false,
              itemName: "item name",
              amount: "11",
              price: 15,
              onPressed: null),
        ),
      ),
    );
  }
}

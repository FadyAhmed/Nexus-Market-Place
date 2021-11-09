import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:flutter/material.dart';

class PurchasedItemsScreen extends StatefulWidget {
  const PurchasedItemsScreen({Key? key}) : super(key: key);

  @override
  _PurchasedItemsScreenState createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends State<PurchasedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: DetailedItemCard(
              amount: "41",
              itemName: "Book",
              price: 15,
              type: "PURSHACED",
              name: "Name",
              date: "9/9/2020",
            )),
      ),
    );
  }
}

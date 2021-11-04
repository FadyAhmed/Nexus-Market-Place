import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:flutter/material.dart';

class SoldItemsScreen extends StatefulWidget {
  const SoldItemsScreen({Key? key}) : super(key: key);

  @override
  _SoldItemsScreenState createState() => _SoldItemsScreenState();
}

class _SoldItemsScreenState extends State<SoldItemsScreen> {
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
              type: "SOLD",
              name: "Fado Ahemd",
              date: "9/9/2020",
            )),
      ),
    );
  }
}

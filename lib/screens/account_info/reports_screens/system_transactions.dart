import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:flutter/material.dart';

class SystemTransactionsScreen extends StatefulWidget {
  const SystemTransactionsScreen({Key? key}) : super(key: key);

  @override
  _SystemTransactionsScreenState createState() =>
      _SystemTransactionsScreenState();
}

class _SystemTransactionsScreenState extends State<SystemTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Transactions"), centerTitle: true),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ItemTransactioinCard(
              amount: "41",
              itemName: "Book",
              price: 15,
              type: "Succesful",
              sellerName: "Name",
              buyerName: "Name",
              date: "9/9/2020",
            )),
      ),
    );
  }
}

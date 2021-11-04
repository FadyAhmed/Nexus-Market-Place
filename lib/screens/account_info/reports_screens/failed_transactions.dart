import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:flutter/material.dart';

class SystemFailedTransactionsScreen extends StatefulWidget {
  const SystemFailedTransactionsScreen({Key? key}) : super(key: key);

  @override
  _SystemFailedTransactionsScreenState createState() =>
      _SystemFailedTransactionsScreenState();
}

class _SystemFailedTransactionsScreenState
    extends State<SystemFailedTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Failed Transactions"), centerTitle: true),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ItemTransactioinCard(
              amount: "41",
              itemName: "Book",
              price: 15,
              reason: "KEDA",
              type: "Failed",
              sellerName: "Fado Ahemd",
              buyerName: "Fado Ahemd",
              date: "9/9/2020",
            )),
      ),
    );
  }
}

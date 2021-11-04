import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/screens/sale/edit_sale_item_details.dart';
import 'package:ds_market_place/screens/sale/on_sale_item_details.dart';
import 'package:ds_market_place/screens/sale/select_item_to_sell.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => SelectItemToSellScreen())),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            itemName: "item name",
            amount: "11",
            price: 15,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OnSaleItemDetailsScreen()));
            },
            onSelectMenuItem: (choice) {
              if (choice == "Edit") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditSaleItemDetails(
                    submitButtonText: "Edit",
                    onSubmit: () => {
                      //TODO: add edit habdler
                      Navigator.of(context).pop()
                    },
                  ),
                ));
              } else {
                //TODO: remove handler
              }
            },
          ),
        ),
      ),
    );
  }
}

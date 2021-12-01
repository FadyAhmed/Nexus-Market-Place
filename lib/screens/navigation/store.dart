import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
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
            // put another value to get it in menu
            menuItems: index % 2 == 0 ? ["Edit"] : ["Edit", "Remove"],
            itemName: "item name",
            amount: "11",
            price: 15,
            onPressed: () {
              var item = InventoryItem(
                name: 'name',
                amount: 1,
                price: 1,
                description: 'description',
                imageLink: 'imageLink',
              );
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OnSaleItemDetailsScreen(item)));
            },
            onSelectMenuItem: (choice) {
              if (choice == "Edit") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditItemDetails(
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

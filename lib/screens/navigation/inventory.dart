import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/inventory/edit_inventory_item_details.dart';
import 'package:ds_market_place/screens/sale/on_sale_item_details.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ItemCard(
                  onSelectMenuItem: (choice) {
                    if (choice == "Edit") {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditInventoryitemDetails(),
                      ));
                    } else {
                      //TODO: remove handler
                      showSnackbar(context, Text("Item removed"));
                    }
                  },
                  itemName: "item name",
                  amount: "11",
                  price: 15,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OnSaleItemDetailsScreen()));
                  })),
        ));
  }
}

import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:flutter/material.dart';

class SelectItemToSellScreen extends StatefulWidget {
  const SelectItemToSellScreen({Key? key}) : super(key: key);

  @override
  _SelectItemToInvenSellnState createState() => _SelectItemToInvenSellnState();
}

class _SelectItemToInvenSellnState extends State<SelectItemToSellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select item to sell"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            color: Colors.grey,
            child: Center(
              child: Text(
                "Items on your inventory",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCard(
                      itemName: "item name",
                      amount: "11",
                      price: 15,
                      showActions: false,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditItemDetails(
                                submitButtonText: "Confirm",
                                onSubmit: () {
                                  showSnackbar(
                                      context, Text("Item added to sale"));

                                  Navigator.of(context).pop();
                                }),
                          ),
                        );
                      })),
            ),
          ),
        ],
      ),
    );
  }
}

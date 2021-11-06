import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:flutter/material.dart';

class OnSaleItemsScreen extends StatefulWidget {
  const OnSaleItemsScreen({Key? key}) : super(key: key);

  @override
  _OnSaleItemsScreenState createState() => _OnSaleItemsScreenState();
}

class _OnSaleItemsScreenState extends State<OnSaleItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            itemName: "item name",
            amount: "11",
            price: 15,
            onPressed: () => {},
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

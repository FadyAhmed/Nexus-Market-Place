import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'edit_item_details.dart';

class OnSaleItemDetailsScreen extends StatefulWidget {
  final InventoryItem item;
  OnSaleItemDetailsScreen(this.item, {Key? key})
      : assert(item.id != null),
        super(key: key);

  @override
  _OnSaleItemDetailsScreenState createState() =>
      _OnSaleItemDetailsScreenState();
}

class _OnSaleItemDetailsScreenState extends State<OnSaleItemDetailsScreen> {
  void submitDelete() async {
    try {
      await Provider.of<InventoriesProvider>(context, listen: false)
          .removeItem(widget.item.id!);
      showSnackbar(context, Text('Item is deleted'));
      Navigator.of(context).pop();
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    InventoryItem item = Provider.of<InventoriesProvider>(context)
        .items!
        .firstWhere((it) => it.id == widget.item.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  kLogo,
                  height: 100,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.grey,
                        child: IconButton(
                          onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditItemDetails(
                                  item: widget.item,
                                  onSubmit: () {
                                    Navigator.of(context).pop();
                                  },
                                  submitButtonText: "Edit",
                                ),
                              ),
                            )
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        color: Colors.red,
                        child: IconButton(
                          onPressed: submitDelete,
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Table(
            //border: TableBorder.all(),
            children: [
              tableRow("Name: ", item.name, context),
              tableRow("", "", context),
              tableRow("Description: ", item.description, context),
              tableRow("", "", context),
              tableRow("Available amount: ", item.amount.toString(), context),
              tableRow("", "", context),
              tableRow(
                  "Price: ", "\$${item.price.toStringAsFixed(2)}", context),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

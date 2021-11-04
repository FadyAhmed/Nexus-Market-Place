import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/screens/inventory/edit_inventory_item_details.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class InventoryItemDetailsScreen extends StatefulWidget {
  const InventoryItemDetailsScreen({Key? key}) : super(key: key);

  @override
  _InventoryItemDetailsScreenState createState() =>
      _InventoryItemDetailsScreenState();
}

class _InventoryItemDetailsScreenState
    extends State<InventoryItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
                Image.asset(kLogo),
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
                                builder: (context) =>
                                    EditInventoryitemDetails(),
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
                          onPressed: () => {},
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
            children: [
              tableRow("Name: ", "info", context),
              tableRow("", "", context),
              tableRow("Name: ", "info", context),
              tableRow("", "", context),
              tableRow("Name: ", "info", context),
              tableRow("", "", context),
              tableRow("Name: ", "info", context),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'edit_sale_item_details.dart';

class OnSaleItemDetailsScreen extends StatefulWidget {
  const OnSaleItemDetailsScreen({Key? key}) : super(key: key);

  @override
  _OnSaleItemDetailsScreenState createState() =>
      _OnSaleItemDetailsScreenState();
}

class _OnSaleItemDetailsScreenState extends State<OnSaleItemDetailsScreen> {
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
                                builder: (context) => EditSaleItemDetails(
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

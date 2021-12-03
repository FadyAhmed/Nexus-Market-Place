import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<InventoriesProvider>(context, listen: false)
        .getAllItems(notifyWhenLoading: false)
        .catchError((e) {
      showMessageDialogue(context, e.message);
    });
  }

  void submitDelete(InventoryItem item) async {
    try {
      await Provider.of<InventoriesProvider>(context, listen: false)
          .removeItem(item.id!);
      showSnackbar(context, Text('Item is deleted'));
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var inventoryProvider = Provider.of<InventoriesProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
          child: const Icon(Icons.add),
        ),
        body: inventoryProvider.loadingStatus == LoadingStatus.loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: inventoryProvider.items!.length,
                itemBuilder: (context, index) {
                  List<InventoryItem> items = inventoryProvider.items!;
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ItemCard(
                          menuItems: ["Edit", "Remove"],
                          onSelectMenuItem: (choice) {
                            if (choice == "Edit") {
                              print(choice);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditItemDetails(
                                  inventoryItem: items[index],
                                  submitButtonText: "Edit",
                                  onSubmit: () => {
                                    //TODO: add edit habdler
                                    Navigator.of(context).pop()
                                  },
                                ),
                              ));
                            } else {
                              submitDelete(items[index]);
                            }
                          },
                          itemName: items[index].name,
                          amount: items[index].amount.toString(),
                          price: items[index].price,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OnSaleItemDetailsScreen(
                                    inventoryItem: items[index])));
                          }));
                },
              ));
  }
}

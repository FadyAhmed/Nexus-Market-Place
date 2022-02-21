import 'dart:async';

import 'package:ds_market_place/components/UI/grey_bar.dart';
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
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  InventoryViewModel inventoryViewModel = GetIt.I<InventoryViewModel>();

  late StreamSubscription loadingSub;
  late StreamSubscription failureSub;

  @override
  void initState() {
    super.initState();

    loadingSub =
        inventoryViewModel.isLoadingController.stream.listen((isLoading) {
      if (isLoading) {
        // removeDialogIfExists(context);
        showLoadingDialog(context);
      } else {
        // removeDialogIfExists(context);
      }
    });

    failureSub =
        inventoryViewModel.failureStreamController.stream.listen((failure) {
      // removeDialogIfExists(context);
      showMessageDialogue(context, failure.message);
    });

    inventoryViewModel.start();
  }

  Future<void> fetchAllInventoryItems({bool notifyWhenLoading = true}) async {
    try {
      await Provider.of<InventoriesProvider>(context, listen: false)
          .getAllItems(notifyWhenLoading: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
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

  Widget buildBody(List<InventoryItem> items) {
    if (items.isEmpty) {
      return GreyBar(
          'No items are found in your inventory.\nPress \'+\' to add one.');
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        InventoryItem item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            menuItems: ["Edit", "Remove"],
            onSelectMenuItem: (choice) {
              if (choice == "Edit") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditItemDetails(
                    inventoryItem: item,
                    submitButtonText: "Edit",
                    onSubmit: () => {Navigator.of(context).pop()},
                  ),
                ));
              } else {
                inventoryViewModel.delete(item.id!);
              }
            },
            itemName: item.name,
            amount: item.amount.toString(),
            price: item.price,
            imageLink: item.imageLink,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      OnSaleItemDetailsScreen(inventoryItem: items[index])));
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var inventoryProvider = Provider.of<InventoriesProvider>(context);
    return RefreshIndicator(
      onRefresh: fetchAllInventoryItems,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder<List<InventoryItem>>(
            stream: inventoryViewModel.inventoryItemsListController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildBody(snapshot.data!);
              }
              return Container();
            },
          )),
    );
  }
}

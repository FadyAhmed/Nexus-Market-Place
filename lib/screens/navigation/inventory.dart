import 'dart:async';

import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
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
  InventoryViewModel inventoryViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    inventoryViewModel.getAllInventoryItems();
  }

  ListView buildList(List<InventoryItem> items) {
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
                      OnSaleItemDetailsScreen(inventoryItem: item)));
            },
          ),
        );
      },
    );
  }

  Widget buildBody() {
    return StreamBuilder<Failure?>(
      stream: inventoryViewModel.failureController.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Center(
            child: MyErrorWidget(
              failure: snapshot.data!,
              onRetry: inventoryViewModel.getAllInventoryItems,
            ),
          );
        }
        return StreamBuilder<bool>(
          stream: inventoryViewModel.isLoadingController.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return Center(child: CircularProgressIndicator());
            }
            return StreamBuilder<List<InventoryItem>>(
              stream: inventoryViewModel.inventoryItemsListController.stream,
              builder: (context, snapshot) {
                List<InventoryItem>? items = snapshot.data;
                if (items == null || items.isEmpty) {
                  return GreyBar(
                      'No items are found in your inventory.\nPress \'+\' to add one.');
                }
                return buildList(items);
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    inventoryViewModel.clearFailure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: inventoryViewModel.getAllInventoryItems,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
            child: const Icon(Icons.add),
          ),
          body: buildBody()),
    );
  }
}

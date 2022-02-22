import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/view_models/item_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'edit_item_details.dart';

class OnSaleItemDetailsScreen extends StatefulWidget {
  final InventoryItem? inventoryItem;
  final StoreItem? storeItem;
  OnSaleItemDetailsScreen({
    Key? key,
    this.inventoryItem,
    this.storeItem,
  })  : assert((inventoryItem != null && inventoryItem.id != null) ||
            (storeItem != null && storeItem.id != null)),
        super(key: key);

  @override
  _OnSaleItemDetailsScreenState createState() =>
      _OnSaleItemDetailsScreenState();
}

class _OnSaleItemDetailsScreenState extends State<OnSaleItemDetailsScreen> {
  ItemDetailsViewModel itemDetailsViewModel = GetIt.I();

  late StreamSubscription isDeletedSub;
  late StreamSubscription failureSub;

  void submitDelete() async {
    if (widget.inventoryItem != null) {
      itemDetailsViewModel
          .removeInventoryItem(itemDetailsViewModel.inventoryItem!.id!);
    } else {
      itemDetailsViewModel
          .removeStoreItemFromMyStore(itemDetailsViewModel.storeItem!.id!);
    }
  }

  void pushEditItemDetailsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditItemDetails(
          inventoryItem: itemDetailsViewModel.inventoryItem,
          storeItem: itemDetailsViewModel.storeItem,
          onSubmit: () {
            Navigator.of(context).pop();
          },
          submitButtonText: "Edit",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    itemDetailsViewModel.start(
      inventoryItem: widget.inventoryItem,
      storeItem: widget.storeItem,
    );

    isDeletedSub =
        itemDetailsViewModel.isDeletedController.stream.listen((isDeleted) {
      if (isDeleted) {
        Navigator.pop(context);
        showSnackbar(context, Text('item deleted successfully'));
      }
    });

    failureSub =
        itemDetailsViewModel.failureController.stream.listen((failure) {
      showMessageDialogue(context, failure.message);
    });
  }

  @override
  void dispose() {
    failureSub.cancel();
    isDeletedSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.inventoryItem != null ? 'Inventory' : 'Store'} Item Details"),
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
        stream: itemDetailsViewModel.itemController.stream,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) return Container();
          InventoryItem? inventoryItem;
          StoreItem? storeItem;
          if (widget.inventoryItem != null) {
            inventoryItem = snapshot.data as InventoryItem;
          } else {
            storeItem = snapshot.data as StoreItem;
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyCachedImg(
                      inventoryItem?.imageLink ?? storeItem!.imageLink,
                      100,
                      100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (inventoryItem != null ||
                              (storeItem != null &&
                                  storeItem.state == StoreItemState.owned))
                            Container(
                              color: Colors.grey,
                              child: IconButton(
                                onPressed: () => pushEditItemDetailsPage(),
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          const SizedBox(width: 15),
                          StreamBuilder<bool>(
                              stream: itemDetailsViewModel
                                  .removingLoadingController.stream,
                              builder: ((context, snapshot) {
                                if (snapshot.data ?? false) {
                                  return SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.red),
                                    ),
                                  );
                                }
                                return Container(
                                  color: Colors.red,
                                  child: IconButton(
                                    onPressed: submitDelete,
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                );
                              })),
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
                  tableRow("Name: ", inventoryItem?.name ?? storeItem!.name,
                      context),
                  tableRow("", "", context),
                  tableRow(
                    "Description: ",
                    inventoryItem?.description ?? storeItem!.description,
                    context,
                  ),
                  tableRow("", "", context),
                  tableRow(
                    "Available amount: ",
                    (inventoryItem?.amount ?? storeItem!.amount).toString(),
                    context,
                  ),
                  tableRow("", "", context),
                  tableRow(
                    "Price: ",
                    "\$${(inventoryItem?.price ?? storeItem!.price).toStringAsFixed(2)}",
                    context,
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          );
        }),
      ),
    );
  }
}

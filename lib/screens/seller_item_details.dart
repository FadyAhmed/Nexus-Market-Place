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
import 'package:flutter/material.dart';
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
  void submitDelete() async {
    try {
      if (widget.inventoryItem != null) {
        await Provider.of<InventoriesProvider>(context, listen: false)
            .removeItem(widget.inventoryItem!.id!);
      } else {
        await Provider.of<StoresProvider>(context, listen: false)
            .removeItemFromMyStore(widget.storeItem!.id!);
      }
      showSnackbar(context, Text('Item is deleted'));
      Navigator.of(context).pop();
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  void pushEditItemDetailsPage(
    InventoriesProvider inventoriesProvider,
    StoresProvider storesProvider,
  ) {
    InventoryItem? inventoryItem = null;
    if (widget.inventoryItem != null)
      inventoryItem = inventoriesProvider.items!
          .firstWhere((item) => item.id == widget.inventoryItem!.id);
    StoreItem? storeItem = null;
    if (widget.storeItem != null)
      storeItem = storesProvider.items!
          .firstWhere((item) => item.id == widget.storeItem!.id);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditItemDetails(
          inventoryItem: inventoryItem,
          storeItem: storeItem,
          onSubmit: () {
            Navigator.of(context).pop();
          },
          submitButtonText: "Edit",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var inventoriesProvider = Provider.of<InventoriesProvider>(context);
    var storesProveider = Provider.of<StoresProvider>(context);
    InventoryItem? inventoryItem;
    StoreItem? storeItem;
    if (widget.inventoryItem != null) {
      inventoryItem = inventoriesProvider.items!.firstWhere(
        (it) => it.id == widget.inventoryItem!.id,
        orElse: () => widget.inventoryItem!,
      );
    } else {
      storeItem = storesProveider.items!.firstWhere(
        (it) => it.id == widget.storeItem!.id,
        orElse: () => widget.storeItem!,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.inventoryItem != null ? 'Inventory' : 'Store'} Item Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyCachedImg(
                  widget.inventoryItem?.imageLink ??
                      widget.storeItem!.imageLink,
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
                            onPressed: () => pushEditItemDetailsPage(
                              inventoriesProvider,
                              storesProveider,
                            ),
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      const SizedBox(width: 15),
                      if (inventoriesProvider.loadingStatus ==
                              LoadingStatus.loading ||
                          storesProveider.loadingStatus ==
                              LoadingStatus.loading)
                        CircularProgressIndicator(color: Colors.red),
                      if (inventoriesProvider.loadingStatus !=
                              LoadingStatus.loading &&
                          storesProveider.loadingStatus !=
                              LoadingStatus.loading)
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
              tableRow(
                  "Name: ", inventoryItem?.name ?? storeItem!.name, context),
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
      ),
    );
  }
}

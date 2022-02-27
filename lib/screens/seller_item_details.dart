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
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:ds_market_place/states/store_items_list_state.dart';
import 'package:ds_market_place/view_models/item_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'edit_item_details.dart';

class OnSaleItemDetailsScreen extends ConsumerStatefulWidget {
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

class _OnSaleItemDetailsScreenState
    extends ConsumerState<OnSaleItemDetailsScreen> {
  void submitDelete() async {
    if (widget.inventoryItem != null) {
      ref
          .read(itemDeleteProvider.notifier)
          .removeInventoryItem(widget.inventoryItem!.id!);
    } else {
      ref
          .read(itemDeleteProvider.notifier)
          .removeStoreItemFromMyStore(widget.storeItem!.id!);
    }
  }

  void pushEditItemDetailsPage({
    InventoryItem? inventoryItem,
    StoreItem? storeItem,
  }) {
    assert(inventoryItem != null || storeItem != null,
        'either inventoryItem or storeItem has to be non-null.');
    assert((inventoryItem != null && storeItem != null) == false,
        "both inventoryItem and storeItem can't be non-null together.");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditItemDetails(
          inventoryItem: inventoryItem,
          storeItem: storeItem,
          submitButtonText: "Edit",
        ),
      ),
    );
  }

  Widget _buildBody({InventoryItem? inventoryItem, StoreItem? storeItem}) {
    assert(inventoryItem != null || storeItem != null,
        'either inventoryItem or storeItem has to be non-null.');
    assert((inventoryItem != null && storeItem != null) == false,
        "both inventoryItem and storeItem can't be non-null together.");
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
                          onPressed: () => pushEditItemDetailsPage(
                            inventoryItem: inventoryItem,
                            storeItem: storeItem,
                          ),
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    const SizedBox(width: 15),
                    Builder(
                      builder: ((context) {
                        final state = ref.watch(itemDeleteProvider);
                        if (state is ItemDeleteLoadingState) {
                          return SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child:
                                  CircularProgressIndicator(color: Colors.red),
                            ),
                          );
                        } else {
                          // initial - error - loaded
                          return Container(
                            color: Colors.red,
                            child: IconButton(
                              onPressed: submitDelete,
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                          );
                        }
                      }),
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
            tableRow("Name: ", inventoryItem?.name ?? storeItem!.name, context),
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
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemDeleteProvider, (previous, next) {
      if (next is ItemDeleteLoadedState) {
        Navigator.pop(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.inventoryItem != null ? 'Inventory' : 'Store'} Item Details"),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (widget.inventoryItem != null) {
          final state = ref.watch(inventoryItemsListProvider);
          if (state is! InventoryItemListLoadedState) {
            return Container();
          }
          InventoryItem item = state.inventoryItems.firstWhere(
            (it) => it.id == widget.inventoryItem!.id!,
            // if item is deleted, it will not be found in the state inventory
            // items, then just use the sent inventory item
            orElse: () => widget.inventoryItem!,
          );
          return _buildBody(inventoryItem: item);
        } else {
          final state = ref.watch(storeItemsListProvider);
          if (state is! StoreItemListLoadedState) {
            return Container();
          }
          StoreItem item = state.storeItems.firstWhere(
            (it) => it.id == widget.storeItem!.id!,
            orElse: () => widget.storeItem!,
          );
          return _buildBody(storeItem: item);
        }
      }),
    );
  }
}

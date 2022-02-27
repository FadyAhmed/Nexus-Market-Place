import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final getAllInventoryItemsProvider =
    FutureProvider.autoDispose<GetAllInventoryItemsResponse>((ref) async {
  await Future.delayed(Duration(seconds: 3));
  return GetIt.I<RestClient>().getAllInventoryItems();
});

final addInventoryItemLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
final getAllInventoryItemsLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final inventoryItemsProvider =
    StateNotifierProvider<InventoryItemsNotifier, List<InventoryItem>?>((ref) {
  return InventoryItemsNotifier(ref);
});

class InventoryItemsNotifier extends StateNotifier<List<InventoryItem>?> {
  InventoryItemsNotifier(this.ref) : super(null);

  StateNotifierProviderRef ref;

  void setInventoryItems(List<InventoryItem> items) {
    state = items;
  }

  void getAllInventoryItems() async {
    ref.watch(getAllInventoryItemsLoadingProvider.notifier).state = true;
    try {
      GetAllInventoryItemsResponse response =
          await GetIt.I<RestClient>().getAllInventoryItems();
      state = [...response.items.map((it) => it.inventoryItem)];
      ref.watch(getAllInventoryItemsLoadingProvider.notifier).state = false;
    } on DioError catch (e) {
      ref.watch(getAllInventoryItemsLoadingProvider.notifier).state = false;
      rethrow;
    }
  }

  Future<void> addItem(AddInventoryItemRequest request) async {
    ref.read(addInventoryItemLoadingProvider.notifier).state = true;
    AddInventoryItemResponse response =
        await GetIt.I<RestClient>().addInventoryItem(request);
    InventoryItem item = request.inventoryItem;
    item.id = response.id;
    state = [...state!, item];
    ref.read(addInventoryItemLoadingProvider.notifier).state = false;
  }
}

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  InventoryViewModel inventoryViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(inventoryItemsListProvider.notifier).getAllInventoryItems,
    );
  }

  Widget buildList(List<InventoryItem> items) {
    if (items.isEmpty) {
      return GreyBar("You have items in your inventory\nPress '+' to add some");
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        InventoryItem item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            itemId: item.id!,
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
                ref
                    .read(itemsDeleteProvider.notifier)
                    .removeInventoryItem(item.id!);
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

  @override
  void dispose() {
    inventoryViewModel.clearFailure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemsDeleteProvider, (previous, next) {
      if (next is ItemDeleteLoadedState) {
        showSnackbar(context, Text('item deleted successfully'));
      }
    });
    return RefreshIndicator(
      onRefresh: inventoryViewModel.getAllInventoryItems,
      child: Scaffold(
        floatingActionButton: Consumer(
          builder: (context, ref, child) => FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AddItemToInventory()));
            },
            child: const Icon(Icons.add),
          ),
        ),
        body: Center(
          child: Builder(builder: (context) {
            final state = ref.watch(inventoryItemsListProvider);
            if (state is InventoryItemListInitialState) {
              return Container();
            } else if (state is InventoryItemListLoadingState) {
              return CircularProgressIndicator();
            } else if (state is InventoryItemListErrorState) {
              return MyErrorWidget(
                failure: state.failure,
                onRetry: ref
                    .read(inventoryItemsListProvider.notifier)
                    .getAllInventoryItems,
              );
            } else if (state is InventoryItemListLoadedState) {
              return buildList(state.inventoryItems);
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

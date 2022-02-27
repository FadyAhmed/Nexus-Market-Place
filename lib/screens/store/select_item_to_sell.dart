import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/store/confirm_to_sell_item.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectItemToSellScreen extends ConsumerStatefulWidget {
  const SelectItemToSellScreen({Key? key}) : super(key: key);

  @override
  _SelectItemToInvenSellnState createState() => _SelectItemToInvenSellnState();
}

class _SelectItemToInvenSellnState
    extends ConsumerState<SelectItemToSellScreen> {
  Widget _buildList(List<InventoryItem> items) {
    if (items.isEmpty) {
      return GreyBar("You have no items in your inventory.");
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
            itemName: item.name,
            amount: item.amount.toString(),
            price: item.price,
            imageLink: item.imageLink,
            showActions: false,
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ConfirmItemToSellScreen(
                    item: item,
                    submitButtonText: "Confirm",
                    onSubmit: () {
                      showSnackbar(context, Text("Item added to sale"));

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(inventoryItemsListProvider.notifier).getAllInventoryItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select item to sell"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GreyBar('Items on your inventory'),
          Expanded(
            child: Center(
              child: Builder(
                builder: ((context) {
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
                  } else {
                    final currentState = state as InventoryItemListLoadedState;
                    return _buildList(currentState.inventoryItems);
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:ds_market_place/states/store_items_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnSaleItemsScreen extends ConsumerStatefulWidget {
  const OnSaleItemsScreen({Key? key}) : super(key: key);

  @override
  _OnSaleItemsScreenState createState() => _OnSaleItemsScreenState();
}

class _OnSaleItemsScreenState extends ConsumerState<OnSaleItemsScreen> {
  Widget buildList(List<StoreItem> items) {
    if (items.isEmpty) {
      return GreyBar('You have no owned items exisiting in your store.');
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        StoreItem item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            itemId: item.id!,
            menuItems: ["Edit", "Remove"],
            itemName: item.name,
            amount: item.amount.toString(),
            price: item.price,
            imageLink: item.imageLink,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OnSaleItemDetailsScreen(storeItem: item))),
            onSelectMenuItem: (choice) {
              if (choice == "Edit") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditItemDetails(
                    storeItem: item,
                    submitButtonText: "Edit",
                  ),
                ));
              } else {
                ref
                    .read(itemDeleteProvider.notifier)
                    .removeStoreItemFromMyStore(item.id!);
              }
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
      ref.read(storeItemsListProvider.notifier).getAllStoreItemsFromMyStore,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemDeleteProvider, (previous, next) {
      if (next is ItemDeleteLoadedState) {
        showSnackbar(context, Text('item is deleted successfully.'));
      }
    });
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            final state = ref.watch(storeItemsListProvider);
            if (state is StoreItemListInitialState) {
              return Container();
            } else if (state is StoreItemListLoadingState) {
              return CircularProgressIndicator();
            } else if (state is StoreItemListErrorState) {
              return MyErrorWidget(
                failure: state.failure,
                onRetry: ref
                    .read(storeItemsListProvider.notifier)
                    .getAllStoreItemsFromMyStore,
              );
            } else {
              final currentState = state as StoreItemListLoadedState;
              List<StoreItem> items = currentState.storeItems
                  .where((item) => item.state == StoreItemState.owned)
                  .toList();
              return buildList(items);
            }
          },
        ),
      ),
    );
  }
}

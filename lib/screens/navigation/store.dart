import 'dart:async';

import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  StoreViewModel storeViewModel = GetIt.I();

  late StreamSubscription removingLoadingSub;

  @override
  void initState() {
    super.initState();
    storeViewModel.getAllStoreItemsFromMyStore();

    removingLoadingSub =
        storeViewModel.removingLoadingController.stream.listen((isLoading) {
      if (isLoading) {
        showLoadingDialog(context);
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    storeViewModel.clearFailure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: storeViewModel.getAllStoreItemsFromMyStore,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => SelectItemToSellScreen())),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<Failure?>(
          stream: storeViewModel.failureController.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Center(
                child: MyErrorWidget(
                  failure: snapshot.data!,
                  onRetry: storeViewModel.getAllStoreItemsFromMyStore,
                ),
              );
            }
            return StreamBuilder<bool>(
              stream: storeViewModel.gettingLoadingController.stream,
              builder: (context, snapshot) {
                if (snapshot.data ?? false) {
                  return Center(child: CircularProgressIndicator());
                }
                return StreamBuilder<List<StoreItem>>(
                  stream: storeViewModel.storeItemsController.stream,
                  builder: (context, snapshot) {
                    List<StoreItem>? items = snapshot.data;
                    if (items == null || items.isEmpty) {
                      return GreyBar(
                          'No items are found in your store.\nPress \'+\' to add one.');
                    }
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        StoreItem item = items[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ItemCard(
                            // put another value to get it in menu
                            menuItems: item.state == StoreItemState.imported
                                ? ["Remove"]
                                : ["Edit", "Remove"],
                            itemName: item.name,
                            amount: item.amount.toString(),
                            price: item.price,
                            imageLink: item.imageLink,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OnSaleItemDetailsScreen(
                                      storeItem: item)));
                            },
                            onSelectMenuItem: (choice) {
                              if (choice == "Edit") {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditItemDetails(
                                    storeItem: item,
                                    submitButtonText: "Edit",
                                    onSubmit: () => {
                                      //TODO: add edit habdler
                                      Navigator.of(context).pop()
                                    },
                                  ),
                                ));
                              } else {
                                storeViewModel
                                    .removeStoreItemFromMyStore(item.id!);
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

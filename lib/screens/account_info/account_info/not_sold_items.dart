import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/view_models/account_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class OnSaleItemsScreen extends ConsumerStatefulWidget {
  const OnSaleItemsScreen({Key? key}) : super(key: key);

  @override
  _OnSaleItemsScreenState createState() => _OnSaleItemsScreenState();
}

class _OnSaleItemsScreenState extends ConsumerState<OnSaleItemsScreen> {
  AccountInfoViewModel accountInfoViewModel = GetIt.I();

  late StreamSubscription removingLoadingSub;
  late StreamSubscription removingFailureSub;

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
                    onSubmit: () => {
                      //TODO: add edit habdler
                      Navigator.of(context).pop()
                    },
                  ),
                ));
              } else {
                accountInfoViewModel.removeStoreItemFromMyStore(item.id!);
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
    accountInfoViewModel.getNotSoldItems();

    removingLoadingSub =
        accountInfoViewModel.removingLoadingController.listen((isLoading) {
      if (isLoading) {
        showLoadingDialog(context);
      } else {
        if (!(ModalRoute.of(context)?.isCurrent ?? true)) {
          Navigator.of(context).pop();
        }
      }
    });

    removingFailureSub =
        accountInfoViewModel.removingFailureController.listen((failure) {
      if (failure != null) {
        showMessageDialogue(context, failure.message);
      }
    });
  }

  @override
  void dispose() {
    accountInfoViewModel.clearFailure();
    removingFailureSub.cancel();
    removingLoadingSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ref.watch(notSoldItemsProvider).when(
              data: buildList,
              error: (err, _) {
                if (err is DioError) {
                  return MyErrorWidget(
                    failure: err.failure,
                    onRetry: () => ref.refresh(notSoldItemsProvider),
                  );
                }
              },
              loading: () => CircularProgressIndicator(),
            ),
      ),
    );
  }
}

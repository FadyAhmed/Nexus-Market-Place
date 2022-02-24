import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/explore/purchase_item.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
import 'package:ds_market_place/view_models/store_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({
    Key? key,
    required this.storeName,
    required this.storeId,
  }) : super(key: key);
  final String storeName;
  final String storeId;
  @override
  _StoreDetailsScreenState createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  StoreDetailsViewModel storeDetailsViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    storeDetailsViewModel.getAllStoreItemsFromParticularStore(widget.storeId);
  }

  @override
  void dispose() {
    storeDetailsViewModel.clearFailure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.storeName),
      ),
      body: StreamBuilder<Failure?>(
        stream: storeDetailsViewModel.failureController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: MyErrorWidget(
                failure: snapshot.data!,
                onRetry: () => storeDetailsViewModel
                    .getAllStoreItemsFromParticularStore(widget.storeId),
              ),
            );
          }
          return StreamBuilder<bool>(
            stream: storeDetailsViewModel.gettingLoadingController.stream,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<List<StoreItem>>(
                stream: storeDetailsViewModel.storeItemsController.stream,
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
                          showActions: false,
                          itemName: item.name,
                          amount: item.amount.toString(),
                          price: item.price,
                          imageLink: item.imageLink,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PurchaseItemScreen(item),
                              ),
                            );
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
    );
  }
}

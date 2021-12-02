import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/explore/purshace_item.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<StoresProvider>(context, listen: false)
        .getAllItemsOfAParticularStore(widget.storeId,
            notifyWhenLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.storeName),
      ),
      body: storesProvider.loadingStatus == LoadingStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: storesProvider.storeItems!.length,
              itemBuilder: (context, index) {
                StoreItem item = storesProvider.storeItems![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCard(
                      showActions: false,
                      itemName: item.name,
                      amount: item.amount.toString(),
                      price: item.price,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PurchaseItemScreen(item)));
                      }),
                );
              },
            ),
    );
  }
}

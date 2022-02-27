import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/explore/purchase_item.dart';
import 'package:ds_market_place/states/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreDetailsScreen extends ConsumerStatefulWidget {
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

class _StoreDetailsScreenState extends ConsumerState<StoreDetailsScreen> {
  Widget _buildList() {
    final state = ref.watch(exploreProvider);
    if (state is! ExploreLoadedState) return Container();
    List<StoreItem> items = state.storeItems
        .where((item) => item.storeName == widget.storeName)
        .toList();

    if (items.isEmpty) {
      return GreyBar("No items are available in this store.");
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        StoreItem item = items[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemCard(
            itemId: item.id!,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.storeName),
      ),
      body: _buildList(),
    );
  }
}

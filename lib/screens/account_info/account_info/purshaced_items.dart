import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchasedItemsScreen extends StatefulWidget {
  const PurchasedItemsScreen({Key? key}) : super(key: key);

  @override
  _PurchasedItemsScreenState createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends State<PurchasedItemsScreen> {
  Future<void> fetchPurchasedItems() async {
    try {
      await Provider.of<TransactionsProvider>(context, listen: false)
          .getPurchasedItems(notifyWhenLoading: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPurchasedItems();
  }

  @override
  Widget build(BuildContext context) {
    var transactionsProvider = Provider.of<TransactionsProvider>(context);
    if (transactionsProvider.purchasedItems != null)
      print(transactionsProvider.purchasedItems!.length);
    return RefreshIndicator(
      onRefresh: fetchPurchasedItems,
      child: Scaffold(
        body: transactionsProvider.loadingStatus == LoadingStatus.loading
            ? Center(child: CircularProgressIndicator())
            : transactionsProvider.purchasedItems!.length == 0
                ? GreyBar(
                    'You haven\'t purchased any item yet.\nGo to \'Explore\' section to buy items.')
                : ListView.builder(
                    itemCount: transactionsProvider.purchasedItems!.length,
                    itemBuilder: (context, index) {
                      Transaction transaction =
                          transactionsProvider.purchasedItems![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DetailedItemCard(
                          amount: transaction.amount.toString(),
                          itemName: transaction.itemName,
                          price: transaction.price,
                          imageLink: transaction.imageLink,
                          type: "PURSHACED",
                          name: transaction.sellerStoreName!,
                          date:
                              DateFormat('dd-MM-yyyy').format(transaction.date),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

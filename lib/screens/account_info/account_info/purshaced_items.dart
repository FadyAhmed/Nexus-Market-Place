import 'package:ds_market_place/components/UI/detailed_item_card.dart';
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
    return RefreshIndicator(
      onRefresh: fetchPurchasedItems,
      child: Scaffold(
        body: transactionsProvider.loadingStatus == LoadingStatus.loading
            ? Center(child: CircularProgressIndicator())
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
                      type: "PURSHACED",
                      name: transaction.storeName,
                      date: DateFormat('dd-MM-yyyy').format(transaction.date),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

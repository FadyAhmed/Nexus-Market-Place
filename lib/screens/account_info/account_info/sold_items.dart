import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SoldItemsScreen extends StatefulWidget {
  const SoldItemsScreen({Key? key}) : super(key: key);

  @override
  _SoldItemsScreenState createState() => _SoldItemsScreenState();
}

class _SoldItemsScreenState extends State<SoldItemsScreen> {
  Future<void> fetchSoldItems() async {
    try {
      await Provider.of<TransactionsProvider>(context, listen: false)
          .getSoldItems(notifyWhenLoading: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSoldItems();
  }

  @override
  Widget build(BuildContext context) {
    var transactionsProvider = Provider.of<TransactionsProvider>(context);
    return RefreshIndicator(
      onRefresh: fetchSoldItems,
      child: Scaffold(
        body: transactionsProvider.loadingStatus == LoadingStatus.loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: transactionsProvider.soldItems!.length,
                itemBuilder: (context, index) {
                  Transaction transaction =
                      transactionsProvider.soldItems![index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DetailedItemCard(
                        amount: transaction.amount.toString(),
                        itemName: transaction.itemName,
                        price: transaction.price,
                        type: "SOLD",
                        name: transaction.storeName,
                        date: DateFormat('dd-MM-yyyy').format(transaction.date),
                      ));
                },
              ),
      ),
    );
  }
}

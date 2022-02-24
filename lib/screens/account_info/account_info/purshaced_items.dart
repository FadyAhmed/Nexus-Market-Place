import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:ds_market_place/view_models/account_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchasedItemsScreen extends StatefulWidget {
  const PurchasedItemsScreen({Key? key}) : super(key: key);

  @override
  _PurchasedItemsScreenState createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends State<PurchasedItemsScreen> {
  AccountInfoViewModel accountInfoViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    accountInfoViewModel.getMyPurchasedItems();
  }

  @override
  void dispose() {
    accountInfoViewModel.clearFailure();
    super.dispose();
  }

  Widget buildList(List<Transaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DetailedItemCard(
            amount: transaction.amount.toString(),
            itemName: transaction.itemName,
            price: transaction.price,
            imageLink: transaction.imageLink,
            type: "SOLD",
            name: transaction.sellerStoreName!,
            date: DateFormat('dd-MM-yyyy').format(transaction.date),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: accountInfoViewModel.getMyPurchasedItems,
      child: Scaffold(
        body: StreamBuilder<Failure?>(
          stream: accountInfoViewModel.failureController.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Center(
                child: MyErrorWidget(
                  failure: snapshot.data!,
                  onRetry: accountInfoViewModel.getMyPurchasedItems,
                ),
              );
            }
            return StreamBuilder<bool>(
              stream: accountInfoViewModel.gettingLoadingController.stream,
              builder: (context, snapshot) {
                if (snapshot.data ?? false) {
                  return Center(child: CircularProgressIndicator());
                }
                return StreamBuilder<List<Transaction>>(
                  stream: accountInfoViewModel.transactionsController.stream,
                  builder: (context, snapshot) {
                    List<Transaction>? transactions = snapshot.data;
                    if (transactions == null || transactions.isEmpty) {
                      return GreyBar('You haven\'t purchased any item yet.');
                    }
                    return buildList(transactions);
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

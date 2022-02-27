import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SystemTransactionsScreen extends ConsumerStatefulWidget {
  const SystemTransactionsScreen({Key? key}) : super(key: key);

  @override
  _SystemTransactionsScreenState createState() =>
      _SystemTransactionsScreenState();
}

class _SystemTransactionsScreenState
    extends ConsumerState<SystemTransactionsScreen> {
  Widget buildList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return GreyBar('No transactions are found in the whole system.');
    }
    return ListView.builder(
      reverse: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemTransactioinCard(
            amount: transaction.amount.toString(),
            itemName: transaction.itemName,
            price: transaction.price,
            imageLink: transaction.imageLink,
            type: "Succesful",
            sellerName: transaction.sellerStoreName!,
            buyerName: transaction.buyerStoreName!,
            date: DateFormat('dd-MM-yyyy').format(transaction.date),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Transactions"), centerTitle: true),
      body: Center(
        child: ref.watch(allTransactionsProvider).when(
              data: buildList,
              error: (err, _) {
                if (err is DioError) {
                  return MyErrorWidget(
                    failure: err.failure,
                    onRetry: () => ref.refresh(soldItemsProvider),
                  );
                }
              },
              loading: () => CircularProgressIndicator(),
            ),
      ),
    );
  }

  
}

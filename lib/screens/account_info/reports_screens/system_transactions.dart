import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:ds_market_place/view_models/transactions_reports_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SystemTransactionsScreen extends StatefulWidget {
  const SystemTransactionsScreen({Key? key}) : super(key: key);

  @override
  _SystemTransactionsScreenState createState() =>
      _SystemTransactionsScreenState();
}

class _SystemTransactionsScreenState extends State<SystemTransactionsScreen> {
  TransactionReportsViewModel transactionReportsViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    transactionReportsViewModel.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Transactions"), centerTitle: true),
      body: StreamBuilder<Failure?>(
        stream: transactionReportsViewModel.failureController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: MyErrorWidget(
                failure: snapshot.data!,
                onRetry: transactionReportsViewModel.getAllTransactions,
              ),
            );
          }
          return StreamBuilder<bool>(
            stream: transactionReportsViewModel.loadingController.stream,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<List<Transaction>>(
                stream:
                    transactionReportsViewModel.transactionsController.stream,
                builder: (context, snapshot) {
                  List<Transaction>? transactions = snapshot.data;
                  if (transactions == null || transactions.isEmpty) {
                    return GreyBar(
                        'No transactions are found in the whole system.');
                  }
                  return buildList(transactions);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget buildList(List<Transaction> transactions) {
    return ListView.builder(
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
}

import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SystemTransactionsScreen extends StatefulWidget {
  const SystemTransactionsScreen({Key? key}) : super(key: key);

  @override
  _SystemTransactionsScreenState createState() =>
      _SystemTransactionsScreenState();
}

class _SystemTransactionsScreenState extends State<SystemTransactionsScreen> {
  void fetchAllTransactions() async {
    try {
      await Provider.of<TransactionsProvider>(context, listen: false)
          .getAllTransactions(notifyWhenLoading: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    var transactionsProvider = Provider.of<TransactionsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("System Transactions"), centerTitle: true),
      body: transactionsProvider.loadingStatus == LoadingStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: transactionsProvider.allTransactions!.length,
              itemBuilder: (context, index) {
                Transaction transaction =
                    transactionsProvider.allTransactions![index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemTransactioinCard(
                      amount: transaction.amount.toString(),
                      itemName: transaction.itemName,
                      price: transaction.price,
                      type: "Succesful",
                      sellerName: transaction.sellerStoreName!,
                      buyerName: transaction.buyerStoreName!,
                      date: DateFormat('dd-MM-yyyy').format(transaction.date),
                    ));
              },
            ),
    );
  }
}

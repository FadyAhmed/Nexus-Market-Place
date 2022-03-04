import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PurchasedItemsScreen extends ConsumerStatefulWidget {
  const PurchasedItemsScreen({Key? key}) : super(key: key);

  @override
  _PurchasedItemsScreenState createState() => _PurchasedItemsScreenState();
}

class _PurchasedItemsScreenState extends ConsumerState<PurchasedItemsScreen> {
  Widget buildList(List<Transaction> transactions) {
    assert(
      transactions.first.sellerStoreName != null,
      'transaction should have a seller store name',
    );
    if (transactions.isEmpty) {
      return GreyBar('You haven\'t purchased any item yet.');
    }
    return ListView.builder(
      reverse: true,
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
      onRefresh: () {
        ref.refresh(purchasedItemsProvider);
        return Future.value(null);
      },
      child: Scaffold(
        body: Center(
          child: ref.watch(purchasedItemsProvider).when(
                data: buildList,
                error: (err, _) {
                  if (err is DioError) {
                    return MyErrorWidget(
                      failure: err.failure,
                      onRetry: () => ref.refresh(purchasedItemsProvider),
                    );
                  }
                },
                loading: () => CircularProgressIndicator(),
              ),
        ),
      ),
    );
  }
}

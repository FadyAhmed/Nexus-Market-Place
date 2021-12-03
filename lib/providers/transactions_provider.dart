import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/services/transactions_web_service.dart';
import 'package:flutter/cupertino.dart';

class TransactionsProvider with ChangeNotifier {
  TransactionsWebService transactionsWebService = TransactionsWebService();

  LoadingStatus loadingStatus = LoadingStatus.done;

  List<Transaction>? soldItems;

  Future<List<Transaction>> getSoldItems() async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      soldItems = await transactionsWebService.getSoldItems();
      return soldItems!;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

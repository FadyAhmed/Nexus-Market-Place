import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/services/transactions_web_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class TransactionsProvider with ChangeNotifier {
  TransactionsWebService transactionsWebService =
      TransactionsWebService(Client());

  LoadingStatus loadingStatus = LoadingStatus.done;

  List<Transaction>? soldItems;
  List<Transaction>? purchasedItems;
  List<Transaction>? allTransactions;

  Future<List<Transaction>> getSoldItems(
      {bool notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      soldItems =
          (await transactionsWebService.getSoldItems()).reversed.toList();
      return soldItems!;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<Transaction>> getPurchasedItems(
      {bool notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      purchasedItems =
          (await transactionsWebService.getPurchasedItems()).reversed.toList();
      return purchasedItems!;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<Transaction>> getAllTransactions(
      {bool notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      allTransactions =
          (await transactionsWebService.getAllTransactions()).reversed.toList();
      return allTransactions!;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

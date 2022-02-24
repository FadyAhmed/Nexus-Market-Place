import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class TransactionReportsViewModel {
  BehaviorSubject<bool> loadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<List<Transaction>> transactionsController = BehaviorSubject();

  List<Transaction>? transactions;

  Future<void> getAllTransactions() async {
    clearFailure();
    loadingController.add(true);
    final response = await GetIt.I<Repository>().getAllTransactions();
    response.fold(
      (failure) {
        loadingController.add(false);
        failureController.add(failure);
      },
      (List<Transaction> transactions) {
        this.transactions = transactions;
        transactionsController.add(transactions);
        loadingController.add(false);
      },
    );
  }

  void clearFailure() {
    failureController.add(null);
  }
}

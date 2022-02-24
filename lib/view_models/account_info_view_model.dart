import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class AccountInfoViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<bool> removingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<Failure?> removingFailureController = BehaviorSubject();
  BehaviorSubject<List<Transaction>> transactionsController = BehaviorSubject();
  BehaviorSubject<List<StoreItem>> notSoldItemsController = BehaviorSubject();

  List<Transaction>? transactions;
  List<StoreItem>? notSoldItems;

  Future<void> getMySoldItems() async {
    clearFailure();
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getMySoldItems();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (List<Transaction> transactions) {
        this.transactions = transactions;
        transactionsController.add(transactions);
        gettingLoadingController.add(false);
      },
    );
  }

  Future<void> getMyPurchasedItems() async {
    clearFailure();
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getMyPurchasedItems();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (List<Transaction> transactions) {
        this.transactions = transactions;
        transactionsController.add(transactions);
        gettingLoadingController.add(false);
      },
    );
  }

  Future<void> getNotSoldItems() async {
    clearFailure();
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getAllStoreItemsFromMyStore();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (List<StoreItem> items) {
        notSoldItems =
            items.where((it) => it.state == StoreItemState.owned).toList();
        notSoldItemsController.add(notSoldItems!);
        gettingLoadingController.add(false);
      },
    );
  }

  void removeStoreItemFromMyStore(String id) async {
    removingLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeStoreItemFromMyStore(id);
    response.fold(
      (failure) {
        removingLoadingController.add(false);
        removingFailureController.add(failure);
        removingFailureController.add(null);
      },
      (_) {
        removingLoadingController.add(false);
        removeLocalItem(id);
      },
    );
  }

  void removeLocalItem(String id) {
    notSoldItems!.removeWhere((item) => item.id == id);
    notSoldItemsController.add(notSoldItems!);
  }

  void editLocalItem(String id, EditStoreItemRequest request) {
    if (notSoldItems == null) return;
    StoreItem item = notSoldItems!.firstWhere((i) => i.id == id);

    item.name = request.name ?? item.name;
    item.price = request.price ?? item.price;
    item.amount = request.amount ?? item.amount;
    item.description = request.description ?? item.description;
    item.imageLink = request.imageLink ?? item.imageLink;

    notSoldItemsController.add(notSoldItems!);
  }

  void clearFailure() {
    failureController.add(null);
  }
}

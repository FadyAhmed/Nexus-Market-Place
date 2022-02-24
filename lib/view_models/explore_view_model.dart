import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ExploreViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<List<StoreItem>> storeItemsController = BehaviorSubject();

  List<StoreItem>? storeItems;

  Future<void> getAllStoreItemsFromAllStores() async {
    failureController.add(null);
    gettingLoadingController.add(true);
    final response =
        await GetIt.I<Repository>().getAllStoreItemsFromAllStores();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (List<StoreItem> items) {
        storeItems = items;
        storeItemsController.add(items);
        gettingLoadingController.add(false);
      },
    );
  }

  void decreaseAmount(String id, int amount) {
    StoreItem item = storeItems!.firstWhere((i) => i.id == id);
    item.amount -= amount;
    if (item.amount == 0) {
      storeItems!.remove(item);
    }
    storeItemsController.add(storeItems!);
  }

  void clearFailure() {
    failureController.add(null);
  }
}

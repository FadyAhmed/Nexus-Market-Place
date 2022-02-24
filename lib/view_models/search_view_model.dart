import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<List<StoreItem>> storeItemsController = BehaviorSubject();

  List<StoreItem>? storeItems;

  Future<void> searchStoreItems(String name) async {
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().searchStoreItems(name);
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
    if (storeItems == null) return;
    if (!storeItems!.any((i) => i.id == id)) return;
    StoreItem item = storeItems!.firstWhere((i) => i.id == id);
    item.amount -= amount;
    if (item.amount == 0) {
      storeItems!.remove(item);
    }
    storeItemsController.add(storeItems!);
  }
}

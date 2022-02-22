import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class StoreViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<bool> removingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<List<StoreItem>> storeItemsController = BehaviorSubject();

  List<StoreItem>? storeItems;

  void getAllStoreItemsFromMyStore() async {
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getAllStoreItemsFromMyStore();
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

  void removeStoreItemFromMyStore(String id) async {
    removingLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeStoreItemFromMyStore(id);
    response.fold(
      (failure) {
        removingLoadingController.add(false);
        failureController.add(failure);
      },
      (_) {
        removingLoadingController.add(false);
        removeLocalItem(id);
      },
    );
  }

  void addLocalItem(StoreItem item) {
    if (storeItems == null) return;
    storeItems!.add(item);
    storeItemsController.add(storeItems!);
  }

  void removeLocalItem(String id) {
    storeItems!.removeWhere((item) => item.id == id);
    storeItemsController.add(storeItems!);
  }

  void editLocalItem(String id, EditStoreItemRequest request) {
    if (storeItems == null) return;
    StoreItem item = storeItems!.firstWhere((i) => i.id == id);

    item.name = request.name ?? item.name;
    item.price = request.price ?? item.price;
    item.amount = request.amount ?? item.amount;
    item.description = request.description ?? item.description;
    item.imageLink = request.imageLink ?? item.imageLink;

    storeItemsController.add(storeItems!);
  }
}

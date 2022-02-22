import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SelectItemToSellViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<List<InventoryItem>> inventoryItemsController =
      BehaviorSubject();

  List<InventoryItem>? inventoryItems;

  void dispose() {
    gettingLoadingController.close();
    failureController.close();
    inventoryItemsController.close();
  }

  void getAllInventoryItems() async {
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getAllInventoryItems();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (List<InventoryItem> items) {
        inventoryItems = items;
        inventoryItemsController.add(items);
        gettingLoadingController.add(false);
      },
    );
  }

  void addLocalItem(InventoryItem item) {
    if (inventoryItems == null) return;

    inventoryItems!.add(item);
    inventoryItemsController.add(inventoryItems!);
  }
}

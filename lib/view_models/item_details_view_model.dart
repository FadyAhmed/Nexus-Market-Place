import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ItemDetailsViewModel {
  InventoryItem? inventoryItem;

  BehaviorSubject<InventoryItem> inventoryItemController = BehaviorSubject();
  BehaviorSubject<bool> isDeleteLoadingController =
      BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<bool> isDeletedController =
      BehaviorSubject<bool>.seeded(false);

  void start(InventoryItem item) {
    // move the initialization of the inventory item to the constructor
    inventoryItem = item;
    inventoryItemController.add(inventoryItem!);
  }

  void dispose() {
    inventoryItemController.close();
    isDeleteLoadingController.close();
    failureController.close();
    isDeletedController.close();
  }

  void updateItem(EditInventoryItemRequest request) {
    if (inventoryItem == null) return;
    inventoryItem!.name = request.name ?? inventoryItem!.name;
    inventoryItem!.amount = request.amount ?? inventoryItem!.amount;
    inventoryItem!.description =
        request.description ?? inventoryItem!.description;
    inventoryItem!.imageLink = request.imageLink ?? inventoryItem!.imageLink;
    inventoryItem!.price = request.price ?? inventoryItem!.price;

    inventoryItemController.add(inventoryItem!);
  }

  void removeItem(String id) async {
    isDeleteLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeInventoryItem(id);
    response.fold((failure) {
      isDeleteLoadingController.add(false);
      failureController.add(failure);
    }, (_) {
      isDeletedController.add(true);
      isDeleteLoadingController.add(false);
      GetIt.I<InventoryViewModel>().removeCachedItem(id);
    });
  }
}

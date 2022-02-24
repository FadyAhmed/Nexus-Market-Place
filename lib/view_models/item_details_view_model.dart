import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/view_models/account_info_view_model.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ItemDetailsViewModel {
  InventoryItem? inventoryItem;
  StoreItem? storeItem;

  BehaviorSubject<Object> itemController = BehaviorSubject();
  BehaviorSubject<bool> removingLoadingController =
      BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<bool> isDeletedController =
      BehaviorSubject<bool>.seeded(false);

  void start({InventoryItem? inventoryItem, StoreItem? storeItem}) {
    // move the initialization of the inventory item to the constructor
    assert(inventoryItem != null || storeItem != null,
        'either inventoryItem or storeItem has to be non-null.');
    assert((inventoryItem != null && storeItem != null) == false,
        "both inventoryItem and storeItem can't be non-null together.");
    this.inventoryItem = inventoryItem;
    this.storeItem = storeItem;
    itemController.add(inventoryItem ?? storeItem!);
  }

  void dispose() {
    itemController.close();
    removingLoadingController.close();
    failureController.close();
    isDeletedController.close();
  }

  void editLocalInventoryItem(EditInventoryItemRequest request) {
    if (inventoryItem == null) return;
    inventoryItem!.name = request.name ?? inventoryItem!.name;
    inventoryItem!.amount = request.amount ?? inventoryItem!.amount;
    inventoryItem!.description =
        request.description ?? inventoryItem!.description;
    inventoryItem!.imageLink = request.imageLink ?? inventoryItem!.imageLink;
    inventoryItem!.price = request.price ?? inventoryItem!.price;

    itemController.add(inventoryItem!);
  }

  void editLocalStoreItem(EditStoreItemRequest request) {
    if (storeItem == null) return;
    storeItem!.name = request.name ?? storeItem!.name;
    storeItem!.amount = request.amount ?? storeItem!.amount;
    storeItem!.description = request.description ?? storeItem!.description;
    storeItem!.imageLink = request.imageLink ?? storeItem!.imageLink;
    storeItem!.price = request.price ?? storeItem!.price;

    itemController.add(storeItem!);
  }

  void removeInventoryItem(String id) async {
    removingLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeInventoryItem(id);
    response.fold((failure) {
      removingLoadingController.add(false);
      failureController.add(failure);
    }, (_) {
      isDeletedController.add(true);
      isDeletedController.add(false); // clear isDeleted flag
      removingLoadingController.add(false);
      GetIt.I<InventoryViewModel>().removeLocalItem(id);
    });
  }

  void removeStoreItemFromMyStore(String id) async {
    removingLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeStoreItemFromMyStore(id);
    response.fold((failure) {
      removingLoadingController.add(false);
      failureController.add(failure);
    }, (_) {
      isDeletedController.add(true);
      isDeletedController.add(false); // clear isDeleted flag
      removingLoadingController.add(false);
      GetIt.I<StoreViewModel>().removeLocalItem(id);
      GetIt.I<AccountInfoViewModel>().removeLocalItem(id);
    });
  }
}

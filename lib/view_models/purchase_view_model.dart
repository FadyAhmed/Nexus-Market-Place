import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/view_models/explore_view_model.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseViewModel {
  StoreItem? storeItem;

  BehaviorSubject<Object> storeItemController = BehaviorSubject();
  BehaviorSubject<bool> purchasingLoadingController = BehaviorSubject();
  BehaviorSubject<bool> addingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<bool> isPurchasedController = BehaviorSubject();
  BehaviorSubject<bool> isAddedController = BehaviorSubject();

  void start(StoreItem item) {
    storeItem = item;
    storeItemController.add(storeItem!);
  }

  void dispose() {
    failureController.close();
    storeItemController.close();
    purchasingLoadingController.close();
    isPurchasedController.close();
  }

  void purchaseStoreItem(String id, PurchaseStoreItemRequest request) async {
    purchasingLoadingController.add(true);
    final response = await GetIt.I<Repository>().purchaseStoreItem(id, request);
    response.fold((failure) {
      purchasingLoadingController.add(false);
      failureController.add(failure);
    }, (_) {
      isPurchasedController.add(true);
      isPurchasedController.add(false); // clear isDeleted flag
      purchasingLoadingController.add(false);

      GetIt.I<ExploreViewModel>().decreaseAmount(id, request.amount);
    });
  }

  void addItemInOtherStoreToMyStore(String id) async {
    addingLoadingController.add(true);
    final response =
        await GetIt.I<Repository>().addItemInOtherStoreToMyStore(id);
    response.fold((failure) {
      addingLoadingController.add(false);
      failureController.add(failure);
      failureController.add(null); //clearing the error
    }, (_) {
      isAddedController.add(true);
      isAddedController.add(false); // clear isDeleted flag
      addingLoadingController.add(false);
    });
  }
}

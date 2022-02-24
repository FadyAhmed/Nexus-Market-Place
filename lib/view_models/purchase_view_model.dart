import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/view_models/explore_view_model.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/search_view_model.dart';
import 'package:ds_market_place/view_models/store_details_view_model.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseViewModel {
  StoreItem? storeItem;

  // PurchaseViewModel mustn't hold any data as it would be generated using
  // a factory in the GEtIt dependency injection
  // it should depend on the data from the previous screens only

  // BehaviorSubject<StoreItem> storeItemController = BehaviorSubject();
  
  BehaviorSubject<bool> purchasingLoadingController = BehaviorSubject();
  BehaviorSubject<bool> addingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<bool> isPurchasedController = BehaviorSubject();
  BehaviorSubject<bool> isAddedController = BehaviorSubject();


  void dispose() {
    failureController.close();
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
      GetIt.I<SearchViewModel>().decreaseAmount(id, request.amount);
      GetIt.I<StoreDetailsViewModel>().decreaseAmount(id, request.amount);
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

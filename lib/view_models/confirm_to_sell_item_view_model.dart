import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmToSellItemViewModel {
  BehaviorSubject<bool> confirmingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<bool> isConfirmedController = BehaviorSubject();

  void dispose() {
    confirmingLoadingController.close();
    failureController.close();
    isConfirmedController.close();
  }

  void addItemInMyInventoryToMyStore(
      String id, AddItemInMyInventoryToMyStoreRequest request) async {
    confirmingLoadingController.add(true);
    final response =
        await GetIt.I<Repository>().addItemInMyInventoryToMyStore(id, request);
    response.fold((failure) {
      confirmingLoadingController.add(false);
      failureController.add(failure);
      failureController.add(null); //clearing the failure
    }, (item) {
      GetIt.I<StoreViewModel>().addLocalItem(item);
      confirmingLoadingController.add(false);
      isConfirmedController.add(true);
      isConfirmedController.add(false); //clearing the flag
    });
  }
}

import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class AddInventoryItemViewModel {
  BehaviorSubject<bool> addingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure> failureController = BehaviorSubject();
  BehaviorSubject<bool> isAddedController = BehaviorSubject();

  void dispose() {
    addingLoadingController.close();
    failureController.close();
    isAddedController.close();
  }

  void addInventoryItem(AddInventoryItemRequest request) async {
    addingLoadingController.add(true);
    final response = await GetIt.I<Repository>().addInventoryItem(request);
    response.fold((failure) {
      addingLoadingController.add(false);
      failureController.add(failure);
    }, (item) {
      GetIt.I<InventoryViewModel>().addItemToLocalList(item);
      addingLoadingController.add(false);
      isAddedController.add(true);
    });
  }
}

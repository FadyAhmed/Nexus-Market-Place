import 'dart:async';

import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/item_details_view_model.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class EditItemViewModel {
  Repository repository = GetIt.I();
  InventoryViewModel inventoryViewModel = GetIt.I();

  BehaviorSubject<bool> editingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure> failureStreamController = BehaviorSubject();
  BehaviorSubject<bool> isEditedController = BehaviorSubject();

  void dispose() {
    editingLoadingController.close();
    failureStreamController.close();
    isEditedController.close();
  }

  Future<void> editInventoryItem(
      String id, EditInventoryItemRequest request) async {
    editingLoadingController.add(true);
    final response = await repository.editInventoryItem(id, request);
    response.fold((failure) {
      failureStreamController.add(failure);
      editingLoadingController.add(false);
    }, (_) {
      GetIt.I<ItemDetailsViewModel>().editLocalInventoryItem(request);
      GetIt.I<InventoryViewModel>().editLocalItem(id, request);
      editingLoadingController.add(false);
      isEditedController.add(true);
      isEditedController.add(false); // clear isEdited flag
    });
  }

  Future<void> editStoreItem(String id, EditStoreItemRequest request) async {
    editingLoadingController.add(true);
    final response = await repository.editStoreItem(id, request);
    response.fold((failure) {
      failureStreamController.add(failure);
      editingLoadingController.add(false);
    }, (_) {
      GetIt.I<ItemDetailsViewModel>().editLocalStoreItem(request);
      GetIt.I<StoreViewModel>().editLocalItem(id, request);
      editingLoadingController.add(false);
      isEditedController.add(true);
      isEditedController.add(false); // clear isEdited flag
    });
  }
}

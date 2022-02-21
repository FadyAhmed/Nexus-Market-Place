import 'dart:async';

import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:get_it/get_it.dart';

class EditInventoryItemViewModel {
  Repository repository = GetIt.I();
  InventoryViewModel inventoryViewModel = GetIt.I();

  StreamController<bool> isLoadingController =
      StreamController<bool>.broadcast();
  StreamController<Failure> failureStreamController =
      StreamController<Failure>.broadcast();

  void start() {
    inventoryViewModel.isLoadingController.stream.listen((isLoading) {
      isLoadingController.add(isLoading);
    });
    inventoryViewModel.failureStreamController.stream.listen((failure) {
      failureStreamController.add(failure);
    });
  }

  Future<void> edit(String id, EditInventoryItemRequest request) async {
    isLoadingController.add(true);
    await inventoryViewModel.edit(id, request);
    isLoadingController.add(false);
  }
}

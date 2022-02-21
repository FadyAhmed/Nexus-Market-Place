import 'dart:async';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:get_it/get_it.dart';

class InventoryViewModel {
  Repository repository = GetIt.instance();

  StreamController<bool> isLoadingController =
      StreamController<bool>.broadcast();
  StreamController<Failure> failureStreamController =
      StreamController<Failure>.broadcast();
  StreamController<List<InventoryItem>> inventoryItemsListController =
      StreamController<List<InventoryItem>>.broadcast();

  List<InventoryItem>? inventoryItems;

  void start() async {
    final response = await repository.getAllInventoryItems();
    response.fold(
      (failure) {
        failureStreamController.add(failure);
      },
      (List<InventoryItem> items) {
        inventoryItems = items;
        inventoryItemsListController.add(items);
      },
    );
  }

  void delete(String id) async {
    isLoadingController.add(true);
    final response = await repository.removeInventoryItem(id);
    response.fold((failure) {
      isLoadingController.add(false);
      failureStreamController.add(failure);
    }, (_) {
      inventoryItems!.removeWhere((item) => item.id == id);
      inventoryItemsListController.add(inventoryItems!);
      isLoadingController.add(false);
    });
  }

  Future<void> edit(String id, EditInventoryItemRequest request) async {
    // isLoadingController.add(true);
    final response = await repository.editInventoryItem(id, request);
    response.fold((failure) {
      // isLoadingController.add(false);
      failureStreamController.add(failure);
    }, (_) {
      updateItem(id, request);
      inventoryItemsListController.add(inventoryItems!);
      // isLoadingController.add(false);
    });
  }

  void updateItem(String id, EditInventoryItemRequest request) {
    InventoryItem item = inventoryItems!.firstWhere((i) => i.id == id);
    item.name = request.name ?? item.name;
    item.amount = request.amount ?? item.amount;
    item.price = request.price ?? item.price;
    item.description = request.description ?? item.description;
    item.imageLink = request.imageLink ?? item.imageLink;
  }
}

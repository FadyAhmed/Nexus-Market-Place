import 'dart:async';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class InventoryViewModel {
  Repository repository = GetIt.instance();

  BehaviorSubject<bool> isLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<List<InventoryItem>> inventoryItemsListController =
      BehaviorSubject();

  List<InventoryItem>? inventoryItems;

  Future<void> getAllInventoryItems() async {
    clearFailure();
    isLoadingController.add(true);
    final response = await repository.getAllInventoryItems();
    response.fold(
      (failure) {
        isLoadingController.add(false);
        failureController.add(failure);
      },
      (List<InventoryItem> items) {
        inventoryItems = items;
        inventoryItemsListController.add(items);
        isLoadingController.add(false);
      },
    );
  }

  void delete(String id) async {
    isLoadingController.add(true);
    final response = await repository.removeInventoryItem(id);
    response.fold((failure) {
      isLoadingController.add(false);
      failureController.add(failure);
    }, (_) {
      inventoryItems!.removeWhere((item) => item.id == id);
      inventoryItemsListController.add(inventoryItems!);
      isLoadingController.add(false);
    });
  }

  Future<void> edit(String id, EditInventoryItemRequest request) async {
    final response = await repository.editInventoryItem(id, request);
    response.fold((failure) {
      failureController.add(failure);
    }, (_) {
      editLocalItem(id, request);
    });
  }

  void editLocalItem(String id, EditInventoryItemRequest request) {
    InventoryItem item = inventoryItems!.firstWhere((i) => i.id == id);
    item.name = request.name ?? item.name;
    item.amount = request.amount ?? item.amount;
    item.price = request.price ?? item.price;
    item.description = request.description ?? item.description;
    item.imageLink = request.imageLink ?? item.imageLink;

    inventoryItemsListController.add(inventoryItems!);
  }

  void removeLocalItem(String id) {
    inventoryItems!.removeWhere((item) => item.id == id);
    inventoryItemsListController.add(inventoryItems!);
  }

  void addItemToLocalList(InventoryItem item) {
    if (inventoryItems == null) {
      return; // could be invoked before fetching items
    }
    inventoryItems!.add(item);
    inventoryItemsListController.add(inventoryItems!);
  }

  void clearFailure() {
    failureController.add(null);
  }
}

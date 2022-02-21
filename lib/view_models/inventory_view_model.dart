import 'dart:async';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class InventoryViewModel {
  Repository repository = GetIt.instance();

  BehaviorSubject<bool> isLoadingController = BehaviorSubject<bool>();
  BehaviorSubject<Failure> failureStreamController = BehaviorSubject<Failure>();
  BehaviorSubject<List<InventoryItem>> inventoryItemsListController =
      BehaviorSubject<List<InventoryItem>>();

  List<InventoryItem>? inventoryItems;

  Future<void> start() async {
    isLoadingController.add(true);
    final response = await repository.getAllInventoryItems();
    response.fold(
      (failure) {
        isLoadingController.add(false);
        failureStreamController.add(failure);
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
      failureStreamController.add(failure);
    }, (_) {
      inventoryItems!.removeWhere((item) => item.id == id);
      inventoryItemsListController.add(inventoryItems!);
      isLoadingController.add(false);
    });
  }

  Future<void> edit(String id, EditInventoryItemRequest request) async {
    final response = await repository.editInventoryItem(id, request);
    response.fold((failure) {
      failureStreamController.add(failure);
    }, (_) {
      updateItem(id, request);
      inventoryItemsListController.add(inventoryItems!);
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

  void removeCachedItem(String id) {
    inventoryItems!.removeWhere((item) => item.id == id);
    inventoryItemsListController.add(inventoryItems!);
  }
}

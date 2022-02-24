import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:dio/dio.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:get_it/get_it.dart';

class Repository {
  RestClient restClient;

  Repository(this.restClient);

// ===========================
// ===========================
// ===========================
// ===========================
// ===========================
// Inventory Items
// ===========================
// ===========================
// ===========================
// ===========================
// ===========================

  Future<Either<Failure, List<InventoryItem>>> getAllInventoryItems() async {
    try {
      GetAllInventoryItemsResponse response =
          await restClient.getAllInventoryItems();
      return Right(response.items.inventoryItems);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> editInventoryItem(
      String id, EditInventoryItemRequest request) async {
    try {
      await restClient.editInventoryItem(id, request);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> removeInventoryItem(String id) async {
    try {
      await restClient.removeInventoryItem(id);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, InventoryItem>> addInventoryItem(
      AddInventoryItemRequest request) async {
    try {
      AddInventoryItemResponse response =
          await restClient.addInventoryItem(request);
      InventoryItem item = request.inventoryItem;
      item.id = response.id;
      return Right(item);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  // ===========================
  // ===========================
  // ===========================
  // ===========================
  // ===========================
  // Store Items
  // ===========================
  // ===========================
  // ===========================
  // ===========================
  // ===========================

  Future<Either<Failure, List<StoreItem>>> getAllStoreItemsFromMyStore() async {
    try {
      GetAllStoreItemsFromMyStoreResponse response =
          await restClient.getAllStoreItemsFromMyStore();
      List<StoreItem> items = response.storeItems;
      return Right(items);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> removeStoreItemFromMyStore(String id) async {
    try {
      await restClient.removeStoreItemFromMyStore(id);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, StoreItem>> addItemInMyInventoryToMyStore(
      String id, AddItemInMyInventoryToMyStoreRequest request) async {
    try {
      AddItemInMyInventoryToMyStoreResponse addItemResponse =
          await restClient.addItemInMyInventoryToMyStore(id, request);
      String storeItemId = addItemResponse.id;
      GetStoreItemResponse getItemResponse =
          await restClient.getStoreItem(storeItemId);
      StoreItem item = getItemResponse.storeItem;
      return Right(item);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> editStoreItem(
      String id, EditStoreItemRequest request) async {
    try {
      await restClient.editStoreItem(id, request);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, StoreItem>> addItemInOtherStoreToMyStore(
      String id) async {
    try {
      AddItemInOtherStoreToMyStoreResponse addItemResponse =
          await restClient.addItemInOtherStoreToMyStore(id);
      StoreItem item = addItemResponse.storeItem;
      return Right(item);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<StoreItem>>>
      getAllStoreItemsFromAllStores() async {
    try {
      GetAllStoreItemsFromAllStoresResponse response =
          await restClient.getAllStoreItemsFromAllStores();
      List<StoreItem> items = response.storeItems;
      return Right(items);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<StoreItem>>> getAllStoreItemsFromParticularStore(
      String id) async {
    try {
      GetAllStoreItemsFromParticularStoreResponse response =
          await restClient.getAllStoreItemsFromParticularStore(id);
      List<StoreItem> items = response.storeItems;
      return Right(items);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<StoreItem>>> searchStoreItems(String name) async {
    try {
      SearchStoreItemsResponse response =
          await restClient.searchStoreItems(name);
      List<StoreItem> items = response.storeItems;
      return Right(items);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, InventoryItem>> purchaseStoreItem(
      String id, PurchaseStoreItemRequest request) async {
    try {
      PurchaseStoreItemResponse purchaseResponse =
          await restClient.purchaseStoreItem(id, request);
      String inventoryItemId = purchaseResponse.id;
      GetInventoryItemResponse getItemResponse =
          await restClient.getInventoryItem(inventoryItemId);
      InventoryItem item = getItemResponse.inventoryItem;
      return Right(item);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

// ===========================
// ===========================
// ===========================
// ===========================
// ===========================
// Transactions
// ===========================
// ===========================
// ===========================
// ===========================
// ===========================

  Future<Either<Failure, List<Transaction>>> getMySoldItems() async {
    try {
      GetMySoldItemsResponse response = await restClient.getMySoldItems();
      return Right(response.transactions);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<Transaction>>> getMyPurchasedItems() async {
    try {
      GetMyPurchasedItemsResponse response =
          await restClient.getMyPurchasedItems();
      return Right(response.transactions);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<Transaction>>> getAllTransactions() async {
    try {
      GetAllTransactionsResponse response =
          await restClient.getAllTransactions();
      return Right(response.transactions);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

// ===========================
// ===========================
// ===========================
// ===========================
// ===========================
// Users
// ===========================
// ===========================
// ===========================
// ===========================
// ===========================

  Future<Either<Failure, void>> signIn(LoginRequest loginRequest) async {
    try {
      LoginResponse response = await restClient.signIn(loginRequest);

      globals.token = response.token;
      globals.storeName = response.storeName;
      globals.admin = response.admin;

      GetIt.instance<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${response.token}';

      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> signUp(SignUpRequest request) async {
    try {
      await restClient.signUp(request);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, Profile>> getProfile() async {
    try {
      ProfileResponse response = await restClient.getProfile();
      return Right(response.profile);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      GetAllUsersResponse response = await restClient.getAllUsers();
      return Right(response.users);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> addBalance(AddBalanceRequest request) async {
    try {
      await restClient.addBalance(request);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, void>> removeBalance(
      RemoveBalanceRequest request) async {
    try {
      await restClient.removeBalance(request);
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }
}

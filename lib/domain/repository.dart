import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:dio/dio.dart';
import 'package:ds_market_place/globals.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:get_it/get_it.dart';

class Repository {
  RestClient restClient;

  Repository(this.restClient);

  Future<Either<Failure, void>> signIn(LoginRequest loginRequest) async {
    try {
      LoginResponse response = await restClient.signIn(loginRequest);

      token = response.token;
      GetIt.instance<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${response.token}';

      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }

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
      restClient.editInventoryItem(id, request);
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
}

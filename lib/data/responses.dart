import 'package:json_annotation/json_annotation.dart';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';

part 'responses.g.dart';

@JsonSerializable()
class LoginResponse {
  bool success;
  String status;
  String token;
  bool admin;
  String storeName;

  LoginResponse({
    required this.success,
    required this.status,
    required this.token,
    required this.admin,
    required this.storeName,
  });

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class GetAllInventoryItemsResponse {
  bool success;
  List<ItemResponse> items;
  GetAllInventoryItemsResponse({
    required this.success,
    required this.items,
  });

  factory GetAllInventoryItemsResponse.fromJson(Map<String, Object?> json) =>
      _$GetAllInventoryItemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllInventoryItemsResponseToJson(this);
}

@JsonSerializable()
class ItemResponse {
  String id;
  String name;
  double price;
  int amount;
  String imageLink;
  String description;
  ItemResponse({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.description,
  });

  factory ItemResponse.fromJson(Map<String, Object?> json) =>
      _$ItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);

  InventoryItem get inventoryItem => InventoryItem(
        id: id,
        name: name,
        amount: amount,
        price: price,
        description: description,
        imageLink: imageLink,
      );
}

extension InventoryItemList on List<ItemResponse> {
  List<InventoryItem> get inventoryItems =>
      map((itemResponse) => itemResponse.inventoryItem).toList();
}

@JsonSerializable()
class RemoveInventoryItemResponse {
  bool success;
  String status;
  RemoveInventoryItemResponse({
    required this.success,
    required this.status,
  });

  factory RemoveInventoryItemResponse.fromJson(Map<String, Object?> json) =>
      _$RemoveInventoryItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveInventoryItemResponseToJson(this);
}

@JsonSerializable()
class EditInventoryItemResponse {
  bool success;
  String status;
  EditInventoryItemResponse({
    required this.success,
    required this.status,
  });

  factory EditInventoryItemResponse.fromJson(Map<String, Object?> json) =>
      _$EditInventoryItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EditInventoryItemResponseToJson(this);
}

@JsonSerializable()
class AddInventoryItemResponse {
  bool success;
  String status;
  String id;
  AddInventoryItemResponse({
    required this.success,
    required this.status,
    required this.id,
  });

  factory AddInventoryItemResponse.fromJson(Map<String, Object?> json) =>
      _$AddInventoryItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddInventoryItemResponseToJson(this);
}

@JsonSerializable()
class GetInventoryItemResponse {
  bool success;
  InventoryItemResponse itemResponse;
  GetInventoryItemResponse({
    required this.success,
    required this.itemResponse,
  });

  factory GetInventoryItemResponse.fromJson(Map<String, Object?> json) =>
      _$GetInventoryItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetInventoryItemResponseToJson(this);

  InventoryItem get inventoryItem => itemResponse.inventoryItem;
}

@JsonSerializable()
class InventoryItemResponse {
  String id;
  String name;
  double price;
  int amount;
  String imageLink;
  String description;

  InventoryItemResponse({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.description,
  });

  factory InventoryItemResponse.fromJson(Map<String, Object?> json) =>
      _$InventoryItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryItemResponseToJson(this);

  InventoryItem get inventoryItem => InventoryItem(
        id: id,
        name: name,
        price: price,
        amount: amount,
        imageLink: imageLink,
        description: description,
      );
}

@JsonSerializable()
class GetAllStoreItemsFromMyStoreResponse {
  bool success;
  List<StoreItemResponse> items;
  GetAllStoreItemsFromMyStoreResponse({
    required this.success,
    required this.items,
  });

  factory GetAllStoreItemsFromMyStoreResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetAllStoreItemsFromMyStoreResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllStoreItemsFromMyStoreResponseToJson(this);

  List<StoreItem> get storeItems => items.map((i) => i.storeItem).toList();
}

@JsonSerializable()
class StoreItemResponse {
  String id;
  String name;
  double price;
  int amount;
  String imageLink;
  String description;
  StoreItemState state;
  String storeId;
  String storeName;

  StoreItemResponse({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.description,
    required this.state,
    required this.storeId,
    required this.storeName,
  });

  factory StoreItemResponse.fromJson(Map<String, Object?> json) =>
      _$StoreItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreItemResponseToJson(this);

  StoreItem get storeItem => StoreItem(
        id: id,
        name: name,
        price: price,
        amount: amount,
        imageLink: imageLink,
        description: description,
        state: state,
        storeId: storeId,
        storeName: storeName,
      );
}

@JsonSerializable()
class RemoveItemFromMyStoreResponse {
  bool success;
  String status;
  RemoveItemFromMyStoreResponse({
    required this.success,
    required this.status,
  });

  factory RemoveItemFromMyStoreResponse.fromJson(Map<String, Object?> json) =>
      _$RemoveItemFromMyStoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveItemFromMyStoreResponseToJson(this);
}

@JsonSerializable()
class AddItemInMyInventoryToMyStoreResponse {
  bool success;
  String status;
  String id;
  AddItemInMyInventoryToMyStoreResponse({
    required this.success,
    required this.status,
    required this.id,
  });

  factory AddItemInMyInventoryToMyStoreResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddItemInMyInventoryToMyStoreResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddItemInMyInventoryToMyStoreResponseToJson(this);
}

@JsonSerializable()
class GetStoreItemResponse {
  bool success;
  StoreItemResponse item;
  GetStoreItemResponse({
    required this.success,
    required this.item,
  });

  factory GetStoreItemResponse.fromJson(Map<String, Object?> json) =>
      _$GetStoreItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetStoreItemResponseToJson(this);

  StoreItem get storeItem => item.storeItem;
}

@JsonSerializable()
class EditStoreItemResponse {
  bool success;
  String status;
  EditStoreItemResponse({
    required this.success,
    required this.status,
  });

  factory EditStoreItemResponse.fromJson(Map<String, Object?> json) =>
      _$EditStoreItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EditStoreItemResponseToJson(this);
}

@JsonSerializable()
class AddItemInOtherStoreToMyStoreResponse {
  bool success;
  String status;
  StoreItemResponse itemResponse;
  AddItemInOtherStoreToMyStoreResponse({
    required this.success,
    required this.status,
    required this.itemResponse,
  });

  factory AddItemInOtherStoreToMyStoreResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddItemInOtherStoreToMyStoreResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddItemInOtherStoreToMyStoreResponseToJson(this);

  StoreItem get storeItem => itemResponse.storeItem;
}

@JsonSerializable()
class GetAllStoreItemsFromAllStoresResponse {
  bool success;
  String status;
  List<StoreItemResponse> itemResponses;
  GetAllStoreItemsFromAllStoresResponse({
    required this.success,
    required this.status,
    required this.itemResponses,
  });

  factory GetAllStoreItemsFromAllStoresResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetAllStoreItemsFromAllStoresResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllStoreItemsFromAllStoresResponseToJson(this);

  List<StoreItem> get storeItems =>
      itemResponses.map((i) => i.storeItem).toList();
}

@JsonSerializable()
class GetAllStoreItemsFromParticularStoreResponse {
  bool success;
  List<StoreItemResponse> itemResponses;
  GetAllStoreItemsFromParticularStoreResponse({
    required this.success,
    required this.itemResponses,
  });

  factory GetAllStoreItemsFromParticularStoreResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetAllStoreItemsFromParticularStoreResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllStoreItemsFromParticularStoreResponseToJson(this);

  List<StoreItem> get storeItems =>
      itemResponses.map((i) => i.storeItem).toList();
}

@JsonSerializable()
class SearchStoreItemsResponse {
  bool success;
  List<StoreItemResponse> itemResponses;
  SearchStoreItemsResponse({
    required this.success,
    required this.itemResponses,
  });

  factory SearchStoreItemsResponse.fromJson(Map<String, Object?> json) =>
      _$SearchStoreItemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchStoreItemsResponseToJson(this);

  List<StoreItem> get storeItems =>
      itemResponses.map((i) => i.storeItem).toList();
}

@JsonSerializable()
class PurchaseStoreItemResponse {
  bool success;
  String status;
  String id;
  PurchaseStoreItemResponse({
    required this.success,
    required this.status,
    required this.id,
  });

  factory PurchaseStoreItemResponse.fromJson(Map<String, Object?> json) =>
      _$PurchaseStoreItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseStoreItemResponseToJson(this);
}

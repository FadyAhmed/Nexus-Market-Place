import 'package:json_annotation/json_annotation.dart';

import 'package:ds_market_place/models/inventory_item.dart';

part 'requests.g.dart';

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

@JsonSerializable()
class LoginRequest {
  String username;
  String password;

  LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  String firsName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String password;
  String storeName;
  SignUpRequest({
    required this.firsName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.storeName,
  });

  factory SignUpRequest.fromJson(Map<String, Object?> json) =>
      _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class AddBalanceRequest {
  String cardNum;
  double amount;
  String cvv;

  AddBalanceRequest({
    required this.cardNum,
    required this.amount,
    required this.cvv,
  });

  factory AddBalanceRequest.fromJson(Map<String, Object?> json) =>
      _$AddBalanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddBalanceRequestToJson(this);
}

@JsonSerializable()
class RemoveBalanceRequest {
  String cardNum;
  double amount;
  String cvv;

  RemoveBalanceRequest({
    required this.cardNum,
    required this.amount,
    required this.cvv,
  });

  factory RemoveBalanceRequest.fromJson(Map<String, Object?> json) =>
      _$RemoveBalanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RemoveBalanceRequestToJson(this);
}

// ===========================
// ===========================
// ===========================
// ===========================
// ===========================
// Inventory
// ===========================
// ===========================
// ===========================
// ===========================
// ===========================

@JsonSerializable()
class EditInventoryItemRequest {
  String? name;
  double? price;
  int? amount;
  String? imageLink;
  String? description;
  EditInventoryItemRequest({
    this.name,
    this.price,
    this.amount,
    this.imageLink,
    this.description,
  });

  factory EditInventoryItemRequest.fromJson(Map<String, Object?> json) =>
      _$EditInventoryItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditInventoryItemRequestToJson(this);
}

@JsonSerializable()
class AddInventoryItemRequest {
  String name;
  double price;
  int amount;
  String imageLink;
  String description;
  AddInventoryItemRequest({
    required this.name,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.description,
  });

  factory AddInventoryItemRequest.fromJson(Map<String, Object?> json) =>
      _$AddInventoryItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddInventoryItemRequestToJson(this);

  InventoryItem get inventoryItem => InventoryItem(
        name: name,
        amount: amount,
        price: price,
        description: description,
        imageLink: imageLink,
      );

  factory AddInventoryItemRequest.fromItem(InventoryItem item) {
    return AddInventoryItemRequest(
      name: item.name,
      price: item.price,
      amount: item.amount,
      imageLink: item.imageLink,
      description: item.description,
    );
  }
}

// ===========================
// ===========================
// ===========================
// ===========================
// ===========================
// Store
// ===========================
// ===========================
// ===========================
// ===========================
// ===========================

@JsonSerializable()
class AddItemInMyInventoryToMyStoreRequest {
  double price;
  int amount;
  AddItemInMyInventoryToMyStoreRequest({
    required this.price,
    required this.amount,
  });

  factory AddItemInMyInventoryToMyStoreRequest.fromJson(
          Map<String, Object?> json) =>
      _$AddItemInMyInventoryToMyStoreRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddItemInMyInventoryToMyStoreRequestToJson(this);
}

@JsonSerializable()
class EditStoreItemRequest {
  String? name;
  double? price;
  int? amount;
  String? imageLink;
  String? description;
  EditStoreItemRequest({
    this.name,
    this.price,
    this.amount,
    this.imageLink,
    this.description,
  });

  factory EditStoreItemRequest.fromJson(Map<String, Object?> json) =>
      _$EditStoreItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditStoreItemRequestToJson(this);
}

@JsonSerializable()
class PurchaseStoreItemRequest {
  int amount;
  PurchaseStoreItemRequest({
    required this.amount,
  });

  factory PurchaseStoreItemRequest.fromJson(Map<String, Object?> json) =>
      _$PurchaseStoreItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseStoreItemRequestToJson(this);
}

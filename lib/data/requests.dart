import 'package:json_annotation/json_annotation.dart';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/inventory_item.dart';

part 'requests.g.dart';

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

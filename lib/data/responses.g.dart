// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      token: json['token'] as String,
      admin: json['admin'] as bool,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'token': instance.token,
      'admin': instance.admin,
      'storeName': instance.storeName,
    };

GetAllInventoryItemsResponse _$GetAllInventoryItemsResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllInventoryItemsResponse(
      success: json['success'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllInventoryItemsResponseToJson(
        GetAllInventoryItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
    };

RemoveInventoryItemResponse _$RemoveInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoveInventoryItemResponseToJson(
        RemoveInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

EditInventoryItemResponse _$EditInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    EditInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$EditInventoryItemResponseToJson(
        EditInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

AddInventoryItemResponse _$AddInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    AddInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$AddInventoryItemResponseToJson(
        AddInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'id': instance.id,
    };

GetAllStoreItemsFromMyStoreResponse
    _$GetAllStoreItemsFromMyStoreResponseFromJson(Map<String, dynamic> json) =>
        GetAllStoreItemsFromMyStoreResponse(
          success: json['success'] as bool,
          items: (json['items'] as List<dynamic>)
              .map((e) => StoreItemResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAllStoreItemsFromMyStoreResponseToJson(
        GetAllStoreItemsFromMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

StoreItemResponse _$StoreItemResponseFromJson(Map<String, dynamic> json) =>
    StoreItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
      state: $enumDecode(_$StoreItemStateEnumMap, json['state']),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$StoreItemResponseToJson(StoreItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
      'state': _$StoreItemStateEnumMap[instance.state],
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

const _$StoreItemStateEnumMap = {
  StoreItemState.owned: 'owned',
  StoreItemState.imported: 'imported',
};

RemoveItemFromMyStoreResponse _$RemoveItemFromMyStoreResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveItemFromMyStoreResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoveItemFromMyStoreResponseToJson(
        RemoveItemFromMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

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

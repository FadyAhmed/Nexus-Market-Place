// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      name: json['name'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageLink: json['imageLink'] as String,
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'price': instance.price,
      'description': instance.description,
      'imageLink': instance.imageLink,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      id: json['id'] as String?,
      name: json['name'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageLink: json['imageLink'] as String,
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['amount'] = instance.amount;
  val['price'] = instance.price;
  val['description'] = instance.description;
  val['imageLink'] = instance.imageLink;
  return val;
}

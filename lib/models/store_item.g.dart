// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreItem _$StoreItemFromJson(Map<String, dynamic> json) => StoreItem(
      id: json['id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
      state: $enumDecode(_$StoreItemStateEnumMap, json['state']),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$StoreItemToJson(StoreItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['price'] = instance.price;
  val['amount'] = instance.amount;
  val['imageLink'] = instance.imageLink;
  val['description'] = instance.description;
  val['state'] = _$StoreItemStateEnumMap[instance.state];
  val['storeId'] = instance.storeId;
  val['storeName'] = instance.storeName;
  return val;
}

const _$StoreItemStateEnumMap = {
  StoreItemState.owned: 'owned',
  StoreItemState.imported: 'imported',
};

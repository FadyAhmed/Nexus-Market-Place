// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      date: DateTime.parse(json['date'] as String),
      sellerStoreId: json['sellerStoreId'] as String?,
      sellerStoreName: json['sellerStoreName'] as String?,
      buyerStoreId: json['buyerStoreId'] as String?,
      buyerStoreName: json['buyerStoreName'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) {
  final val = <String, dynamic>{
    'itemName': instance.itemName,
    'price': instance.price,
    'amount': instance.amount,
    'imageLink': instance.imageLink,
    'date': instance.date.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sellerStoreId', instance.sellerStoreId);
  writeNotNull('sellerStoreName', instance.sellerStoreName);
  writeNotNull('buyerStoreId', instance.buyerStoreId);
  writeNotNull('buyerStoreName', instance.buyerStoreName);
  return val;
}

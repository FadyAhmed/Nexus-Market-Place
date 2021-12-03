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
      buyerStoreId: json['buyerStoreId'] as String,
      buyerStoreName: json['buyerStoreName'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'date': instance.date.toIso8601String(),
      'buyerStoreId': instance.buyerStoreId,
      'buyerStoreName': instance.buyerStoreName,
    };

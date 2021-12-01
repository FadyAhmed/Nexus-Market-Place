// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_balance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBalanceRequest _$AddBalanceRequestFromJson(Map<String, dynamic> json) =>
    AddBalanceRequest(
      cardNum: json['cardNum'] as String,
      amount: (json['amount'] as num).toDouble(),
      cvv: json['cvv'] as String,
    );

Map<String, dynamic> _$AddBalanceRequestToJson(AddBalanceRequest instance) =>
    <String, dynamic>{
      'cardNum': instance.cardNum,
      'amount': instance.amount,
      'cvv': instance.cvv,
    };

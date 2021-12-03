// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      storeName: json['storeName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'storeName': instance.storeName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
    };

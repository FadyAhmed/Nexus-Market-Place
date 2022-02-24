// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'storeName': instance.storeName,
    };

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

RemoveBalanceRequest _$RemoveBalanceRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveBalanceRequest(
      cardNum: json['cardNum'] as String,
      amount: (json['amount'] as num).toDouble(),
      cvv: json['cvv'] as String,
    );

Map<String, dynamic> _$RemoveBalanceRequestToJson(
        RemoveBalanceRequest instance) =>
    <String, dynamic>{
      'cardNum': instance.cardNum,
      'amount': instance.amount,
      'cvv': instance.cvv,
    };

EditInventoryItemRequest _$EditInventoryItemRequestFromJson(
        Map<String, dynamic> json) =>
    EditInventoryItemRequest(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      amount: json['amount'] as int?,
      imageLink: json['imageLink'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EditInventoryItemRequestToJson(
    EditInventoryItemRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('amount', instance.amount);
  writeNotNull('imageLink', instance.imageLink);
  writeNotNull('description', instance.description);
  return val;
}

AddInventoryItemRequest _$AddInventoryItemRequestFromJson(
        Map<String, dynamic> json) =>
    AddInventoryItemRequest(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AddInventoryItemRequestToJson(
        AddInventoryItemRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
    };

AddItemInMyInventoryToMyStoreRequest
    _$AddItemInMyInventoryToMyStoreRequestFromJson(Map<String, dynamic> json) =>
        AddItemInMyInventoryToMyStoreRequest(
          price: (json['price'] as num).toDouble(),
          amount: json['amount'] as int,
        );

Map<String, dynamic> _$AddItemInMyInventoryToMyStoreRequestToJson(
        AddItemInMyInventoryToMyStoreRequest instance) =>
    <String, dynamic>{
      'price': instance.price,
      'amount': instance.amount,
    };

EditStoreItemRequest _$EditStoreItemRequestFromJson(
        Map<String, dynamic> json) =>
    EditStoreItemRequest(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      amount: json['amount'] as int?,
      imageLink: json['imageLink'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EditStoreItemRequestToJson(
    EditStoreItemRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('amount', instance.amount);
  writeNotNull('imageLink', instance.imageLink);
  writeNotNull('description', instance.description);
  return val;
}

PurchaseStoreItemRequest _$PurchaseStoreItemRequestFromJson(
        Map<String, dynamic> json) =>
    PurchaseStoreItemRequest(
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$PurchaseStoreItemRequestToJson(
        PurchaseStoreItemRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
    };

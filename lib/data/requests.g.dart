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

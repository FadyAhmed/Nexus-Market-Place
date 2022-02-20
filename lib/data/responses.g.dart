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

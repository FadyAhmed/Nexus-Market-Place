import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class LoginResponse {
  bool success;
  String status;
  String token;
  bool admin;
  String storeName;

  LoginResponse({
    required this.success,
    required this.status,
    required this.token,
    required this.admin,
    required this.storeName,
  });

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

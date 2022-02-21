import 'package:json_annotation/json_annotation.dart';

part 'requests.g.dart';

@JsonSerializable()
class LoginRequest {
  String username;
  String password;

  LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class EditInventoryItemRequest {
  String? name;
  double? price;
  int? amount;
  String? imageLink;
  String? description;
  EditInventoryItemRequest({
    this.name,
    this.price,
    this.amount,
    this.imageLink,
    this.description,
  });

  factory EditInventoryItemRequest.fromJson(Map<String, Object?> json) =>
      _$EditInventoryItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditInventoryItemRequestToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String firstName;
  String lastName;
  String storeName;
  String email;
  String phoneNumber;
  double balance;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.storeName,
    required this.email,
    required this.phoneNumber,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

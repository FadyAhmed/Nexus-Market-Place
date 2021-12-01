import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  String id;
  String firstName;
  String lastName;
  double balance;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.balance,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  String toString() => toJson().toString();
}

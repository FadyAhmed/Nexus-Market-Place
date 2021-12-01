import 'package:json_annotation/json_annotation.dart';

part 'add_balance_request.g.dart';

@JsonSerializable()
class AddBalanceRequest {
  String cardNum;
  double amount;
  String cvv;

  AddBalanceRequest({
    required this.cardNum,
    required this.amount,
    required this.cvv,
  });

  factory AddBalanceRequest.fromJson(Map<String, dynamic> json) =>
      _$AddBalanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddBalanceRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

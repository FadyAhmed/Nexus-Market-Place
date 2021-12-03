import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  String itemName;
  double price;
  int amount;
  String imageLink;
  DateTime date;
  String buyerStoreId;
  String buyerStoreName;

  Transaction({
    required this.itemName,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.date,
    required this.buyerStoreId,
    required this.buyerStoreName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

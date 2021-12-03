import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  String itemName;
  double price;
  int amount;
  String imageLink;
  DateTime date;
  String? sellerStoreId;
  String? sellerStoreName;
  String? buyerStoreId;
  String? buyerStoreName;

  Transaction({
    required this.itemName,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.date,
    required this.sellerStoreId,
    required this.sellerStoreName,
    required this.buyerStoreId,
    required this.buyerStoreName,
  });

  // removing 'buyer' and 'seller' words before storeName and storeId
  static Map<String, dynamic> normalizeJson(Map<String, dynamic> json) {
    Map<String, dynamic> newJson = {...json};
    newJson['storeId'] = json['buyerStoreId'] ?? json['sellerStoreId'];
    newJson['storeName'] = json['buyerStoreName'] ?? json['sellerStoreName'];
    newJson.removeWhere(
      (key, value) => [
        'buyerStoreId',
        'sellerStoreId',
        'buyerStoreName',
        'sellerStoreName',
      ].contains(key),
    );
    return newJson;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

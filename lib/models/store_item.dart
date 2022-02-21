import 'package:ds_market_place/models/inventory_item.dart';
import 'package:json_annotation/json_annotation.dart';
import '../constants/enums.dart';

part 'store_item.g.dart';

@JsonSerializable()
class StoreItem {
  @JsonKey(includeIfNull: false)
  String? id;
  String name;
  double price;
  int amount;
  String imageLink;
  String description;
  @JsonKey(includeIfNull: false)
  StoreItemState? state;
  String storeId;
  String storeName;

  StoreItem({
    this.id,
    required this.name,
    required this.price,
    required this.amount,
    required this.imageLink,
    required this.description,
    required this.state,
    required this.storeId,
    required this.storeName,
  });

  InventoryItem toInventoryItem() {
    return InventoryItem(
      name: name,
      amount: amount,
      price: price,
      description: description,
      imageLink: imageLink,
    );
  }

  factory StoreItem.fromJson(Map<String, dynamic> json) =>
      _$StoreItemFromJson(json);

  Map<String, dynamic> toJson() => _$StoreItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

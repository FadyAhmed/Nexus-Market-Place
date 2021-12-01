import 'package:json_annotation/json_annotation.dart';

part 'inventory_item.g.dart';

@JsonSerializable()
class InventoryItem {
  String name;
  int amount;
  double price;
  String description;
  String imageLink;

  InventoryItem({
    required this.name,
    required this.amount,
    required this.price,
    required this.description,
    required this.imageLink,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

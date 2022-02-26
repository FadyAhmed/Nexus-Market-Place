import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/models/inventory_item.dart';

abstract class InventoryItemListState extends Equatable {}

class InventoryItemListInitialState extends InventoryItemListState {
  @override
  List<Object?> get props => [];
}

class InventoryItemListLoadingState extends InventoryItemListState {
  @override
  List<Object?> get props => [];
}

class InventoryItemListLoadedState extends InventoryItemListState {
  // TODO: make InventoryItem extend Equatable if it had to
  final List<InventoryItem> inventoryItems;
  InventoryItemListLoadedState({
    required this.inventoryItems,
  });

  @override
  List<Object?> get props => [inventoryItems];

  InventoryItemListLoadedState copyWith({
    List<InventoryItem>? inventoryItems,
  }) {
    return InventoryItemListLoadedState(
      inventoryItems: inventoryItems ?? this.inventoryItems,
    );
  }
}

class InventoryItemListErrorState extends InventoryItemListState {
  final Failure failure;
  InventoryItemListErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class InventoryItemDeleteState extends Equatable {}

class InventoryItemDeleteInitialState extends InventoryItemDeleteState {
  @override
  List<Object?> get props => [];
}

class InventoryItemDeleteLoadingState extends InventoryItemDeleteState {
  final String deletedItemId;
  InventoryItemDeleteLoadingState({
    required this.deletedItemId,
  });
  @override
  List<Object?> get props => [deletedItemId];
}

class InventoryItemDeleteLoadedState extends InventoryItemDeleteState {
  final String deletedItemId;
  InventoryItemDeleteLoadedState({
    required this.deletedItemId,
  });
  @override
  List<Object?> get props => [deletedItemId];
}

class InventoryItemDeleteErrorState extends InventoryItemDeleteState {
  final Failure failure;
  final String deletedItemId;
  InventoryItemDeleteErrorState({
    required this.failure,
    required this.deletedItemId,
  });

  @override
  List<Object?> get props => [failure, deletedItemId];
}

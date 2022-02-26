import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class InventoryItemEditState extends Equatable {}

class InventoryItemEditInitialState extends InventoryItemEditState {
  @override
  List<Object?> get props => [];
}

class InventoryItemEditLoadingState extends InventoryItemEditState {
  @override
  List<Object?> get props => [];
}

class InventoryItemEditLoadedState extends InventoryItemEditState {
  @override
  List<Object?> get props => [];
}

class InventoryItemEditErrorState extends InventoryItemEditState {
  final Failure failure;
  InventoryItemEditErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

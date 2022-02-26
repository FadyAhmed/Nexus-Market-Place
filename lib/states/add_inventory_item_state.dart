import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class AddInventoryItemState extends Equatable {}

class AddInventoryItemInitialState extends AddInventoryItemState {
  @override
  List<Object?> get props => [];
}

class AddInventoryItemLoadingState extends AddInventoryItemState {
  @override
  List<Object?> get props => [];
}

class AddInventoryItemLoadedState extends AddInventoryItemState {
  @override
  List<Object?> get props => [];
}

class AddInventoryItemErrorState extends AddInventoryItemState {
  final Failure failure;
  AddInventoryItemErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

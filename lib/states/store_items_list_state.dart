import 'package:ds_market_place/models/store_item.dart';
import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class StoreItemListState extends Equatable {}

class StoreItemListInitialState extends StoreItemListState {
  @override
  List<Object?> get props => [];
}

class StoreItemListLoadingState extends StoreItemListState {
  @override
  List<Object?> get props => [];
}

class StoreItemListLoadedState extends StoreItemListState {
  final List<StoreItem> storeItems;
  StoreItemListLoadedState({
    required this.storeItems,
  });

  @override
  List<Object?> get props => [storeItems];

  StoreItemListLoadedState copyWith({
    List<StoreItem>? storeItems,
  }) {
    return StoreItemListLoadedState(
      storeItems: storeItems ?? this.storeItems,
    );
  }
}

class StoreItemListErrorState extends StoreItemListState {
  final Failure failure;
  StoreItemListErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

import 'package:ds_market_place/models/store_item.dart';
import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class StoreState extends Equatable {}

class StoreInitialState extends StoreState {
  @override
  List<Object?> get props => [];
}

class StoreLoadingState extends StoreState {
  @override
  List<Object?> get props => [];
}

class StoreLoadedState extends StoreState {
  final List<StoreItem> storeItems;
  StoreLoadedState({
    required this.storeItems,
  });

  @override
  List<Object?> get props => [storeItems];

  StoreLoadedState copyWith({
    List<StoreItem>? storeItems,
  }) {
    return StoreLoadedState(
      storeItems: storeItems ?? this.storeItems,
    );
  }
}

class StoreErrorState extends StoreState {
  final Failure failure;
  StoreErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

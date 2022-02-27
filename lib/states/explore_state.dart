import 'package:ds_market_place/models/store_item.dart';
import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/models/inventory_item.dart';

abstract class ExploreState extends Equatable {}

class ExploreInitialState extends ExploreState {
  @override
  List<Object?> get props => [];
}

class ExploreLoadingState extends ExploreState {
  @override
  List<Object?> get props => [];
}

class ExploreLoadedState extends ExploreState {
  final List<StoreItem> storeItems;
  ExploreLoadedState({
    required this.storeItems,
  });

  @override
  List<Object?> get props => [storeItems];

  ExploreLoadedState copyWith({
    List<StoreItem>? storeItems,
  }) {
    return ExploreLoadedState(
      storeItems: storeItems ?? this.storeItems,
    );
  }
}

class ExploreErrorState extends ExploreState {
  final Failure failure;
  ExploreErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

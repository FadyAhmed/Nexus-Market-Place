import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class ItemDeleteState extends Equatable {}

class ItemDeleteInitialState extends ItemDeleteState {
  @override
  List<Object?> get props => [];
}

class ItemDeleteLoadingState extends ItemDeleteState {
  final String deletedItemId;
  ItemDeleteLoadingState({
    required this.deletedItemId,
  });
  @override
  List<Object?> get props => [deletedItemId];
}

class ItemDeleteLoadedState extends ItemDeleteState {
  final String deletedItemId;
  ItemDeleteLoadedState({
    required this.deletedItemId,
  });
  @override
  List<Object?> get props => [deletedItemId];
}

class ItemDeleteErrorState extends ItemDeleteState {
  final Failure failure;
  final String deletedItemId;
  ItemDeleteErrorState({
    required this.failure,
    required this.deletedItemId,
  });

  @override
  List<Object?> get props => [failure, deletedItemId];
}

import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class ItemEditState extends Equatable {}

class ItemEditInitialState extends ItemEditState {
  @override
  List<Object?> get props => [];
}

class ItemEditLoadingState extends ItemEditState {
  @override
  List<Object?> get props => [];
}

class ItemEditLoadedState extends ItemEditState {
  @override
  List<Object?> get props => [];
}

class ItemEditErrorState extends ItemEditState {
  final Failure failure;
  ItemEditErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

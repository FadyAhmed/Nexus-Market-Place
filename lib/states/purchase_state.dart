import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class PurchaseState extends Equatable {}

class PurchaseInitialState extends PurchaseState {
  @override
  List<Object?> get props => [];
}

class PurchaseLoadingState extends PurchaseState {
  @override
  List<Object?> get props => [];
}

class PurchaseLoadedState extends PurchaseState {
  @override
  List<Object?> get props => [];
}

class PurchaseErrorState extends PurchaseState {
  final Failure failure;
  PurchaseErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

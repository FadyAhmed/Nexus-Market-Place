import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class BalanceState extends Equatable {}

class BalanceInitialState extends BalanceState {
  @override
  List<Object?> get props => [];
}

class BalanceLoadingState extends BalanceState {
  @override
  List<Object?> get props => [];
}

class BalanceLoadedState extends BalanceState {
  final double balance;
  BalanceLoadedState({
    required this.balance,
  });
  @override
  List<Object?> get props => [balance];
}

class BalanceErrorState extends BalanceState {
  final Failure failure;
  BalanceErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

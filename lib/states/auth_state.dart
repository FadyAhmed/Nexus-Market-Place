import 'package:equatable/equatable.dart';

import 'package:ds_market_place/domain/failure.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final Failure failure;
  AuthErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

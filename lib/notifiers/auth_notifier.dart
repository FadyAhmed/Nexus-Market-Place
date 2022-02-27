import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AutoDisposeStateNotifierProviderRef ref;

  AuthNotifier(this.ref) : super(AuthInitialState());

  void signIn(LoginRequest request) async {
    state = AuthLoadingState();
    final response = await GetIt.I<Repository>().signIn(request);
    response.fold(
      (failure) => state = AuthErrorState(failure: failure),
      (_) {
        state = AuthLoadedState();
      },
    );
  }

  void signUp(SignUpRequest request) async {
    state = AuthLoadingState();
    final response = await GetIt.I<Repository>().signUp(request);
    response.fold(
      (failure) => state = AuthErrorState(failure: failure),
      (_) {
        state = AuthLoadedState();
      },
    );
  }
}

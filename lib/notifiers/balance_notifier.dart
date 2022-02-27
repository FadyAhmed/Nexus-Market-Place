import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/balance_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class BalanceNotifier extends StateNotifier<BalanceState> {
  AutoDisposeStateNotifierProviderRef ref;

  BalanceNotifier(this.ref) : super(BalanceInitialState());

  void getBalance() async {
    state = BalanceLoadingState();
    final response = await GetIt.I<Repository>().getProfile();
    response.fold(
      (failure) => state = BalanceErrorState(failure: failure),
      (profile) {
        state = BalanceLoadedState(balance: profile.balance);
        ref.read(balanceAmountProvider.notifier).state = profile.balance;
      },
    );
  }

  void addBalance(AddBalanceRequest request) async {
    assert(
      ref.read(balanceAmountProvider) != null,
      'should call BalanceNotifier.getBalance first before calling addBalance',
    );
    state = BalanceLoadingState();
    final response = await GetIt.I<Repository>().addBalance(request);
    response.fold(
      (failure) => state = BalanceErrorState(failure: failure),
      (_) {
        double balance = ref.read(balanceAmountProvider)! + request.amount;
        // caaling ref.watch would dispose this provider !!!
        ref.read(balanceAmountProvider.notifier).state = balance;
        if (!mounted) return;
        state = BalanceLoadedState(balance: balance);
      },
    );
  }

  void removeBalance(RemoveBalanceRequest request) async {
    assert(
      ref.read(balanceAmountProvider) != null,
      'should call BalanceNotifier.getBalance first before calling removeBalance',
    );
    state = BalanceLoadingState();
    final response = await GetIt.I<Repository>().removeBalance(request);
    response.fold(
      (failure) => state = BalanceErrorState(failure: failure),
      (_) {
        double balance = ref.read(balanceAmountProvider)! - request.amount;
        ref.read(balanceAmountProvider.notifier).state = balance;
        state = BalanceLoadedState(balance: balance);
      },
    );
  }
}

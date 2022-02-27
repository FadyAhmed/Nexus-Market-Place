import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/states/purchase_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  AutoDisposeStateNotifierProviderRef ref;

  PurchaseNotifier(this.ref) : super(PurchaseInitialState());

  void purchaseStoreItem(String id, PurchaseStoreItemRequest request) async {
    state = PurchaseLoadingState();
    final response = await GetIt.I<Repository>().purchaseStoreItem(id, request);
    response.fold(
      (failure) => state = PurchaseErrorState(failure: failure),
      (item) {
        ref
            .read(exploreProvider.notifier)
            .decrementAmountofItemInState(id, request.amount);
        ref
            .read(inventoryItemsListProvider.notifier)
            .addInventoryItemToState(item);
        state = PurchaseLoadedState();
      },
    );
  }
}

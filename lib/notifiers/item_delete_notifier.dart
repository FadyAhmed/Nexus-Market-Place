import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class ItemDeleteNotifier extends StateNotifier<ItemDeleteState> {
  AutoDisposeStateNotifierProviderRef ref;

  ItemDeleteNotifier(this.ref) : super(ItemDeleteInitialState());

  void removeInventoryItem(String id) async {
    state = ItemDeleteLoadingState(deletedItemId: id);
    final response = await GetIt.I<Repository>().removeInventoryItem(id);
    response.fold(
      (failure) => state = ItemDeleteErrorState(
        failure: failure,
        deletedItemId: id,
      ),
      (_) {
        ref.read(inventoryItemsListProvider.notifier).removeItemFromState(id);
        state = ItemDeleteLoadedState(deletedItemId: id);
      },
    );
  }

  void removeStoreItemFromMyStore(String id) async {
    state = ItemDeleteLoadingState(deletedItemId: id);
    final response = await GetIt.I<Repository>().removeStoreItemFromMyStore(id);
    response.fold(
      (failure) => state = ItemDeleteErrorState(
        failure: failure,
        deletedItemId: id,
      ),
      (_) {
        ref.read(storeItemsListProvider.notifier).removeItemFromState(id);
        state = ItemDeleteLoadedState(deletedItemId: id);
      },
    );
  }
}

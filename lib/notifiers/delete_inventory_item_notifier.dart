import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/inventory_item_edit_state.dart';
import 'package:ds_market_place/states/inventory_item_delete_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class InventoryItemDeleteNotifier
    extends StateNotifier<InventoryItemDeleteState> {
  StateNotifierProviderRef ref;

  InventoryItemDeleteNotifier(this.ref)
      : super(InventoryItemDeleteInitialState());

  void removeInventoryItem(String id) async {
    state = InventoryItemDeleteLoadingState(deletedItemId: id);
    final response = await GetIt.I<Repository>().removeInventoryItem(id);
    response.fold(
      (failure) => state = InventoryItemDeleteErrorState(
        failure: failure,
        deletedItemId: id,
      ),
      (_) {
        ref.read(inventoryItemsListProvider.notifier).removeItemFromState(id);
        state = InventoryItemDeleteLoadedState(deletedItemId: id);
      },
    );
  }
}

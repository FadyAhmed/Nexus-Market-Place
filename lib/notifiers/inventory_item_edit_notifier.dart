import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/inventory_item_edit_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class InventoryItemEditNotifier extends StateNotifier<InventoryItemEditState> {
  StateNotifierProviderRef ref;

  InventoryItemEditNotifier(this.ref) : super(InventoryItemEditInitialState());

  void addInventoryItem(AddInventoryItemRequest request) async {
    state = InventoryItemEditLoadingState();
    final response = await GetIt.I<Repository>().addInventoryItem(request);
    response.fold(
      (failure) => state = InventoryItemEditErrorState(failure: failure),
      (item) {
        ref
            .read(inventoryItemsListProvider.notifier)
            .addInventoryItemToState(item);
        state = InventoryItemEditLoadedState();
      },
    );
  }

  void editInventoryItem(String id, EditInventoryItemRequest request) async {
    state = InventoryItemEditLoadingState();
    final response = await GetIt.I<Repository>().editInventoryItem(id, request);
    response.fold(
      (failure) => state = InventoryItemEditErrorState(failure: failure),
      (_) {
        ref
            .read(inventoryItemsListProvider.notifier)
            .editItemInState(id, request);
        state = InventoryItemEditLoadedState();
      },
    );
  }
}

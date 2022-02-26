import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class InventoryItemListNotifier extends StateNotifier<InventoryItemListState> {
  InventoryItemListNotifier() : super(InventoryItemListInitialState());

  void getAllInventoryItems() async {
    state = InventoryItemListLoadingState();
    final response = await GetIt.I<Repository>().getAllInventoryItems();
    response.fold(
      (failure) => state = InventoryItemListErrorState(failure: failure),
      (inventoryItems) =>
          state = InventoryItemListLoadedState(inventoryItems: inventoryItems),
    );
  }

  void addInventoryItemToState(InventoryItem item) {
    if (state is InventoryItemListLoadedState) {
      state = (state as InventoryItemListLoadedState).copyWith(
        inventoryItems: [
          ...(state as InventoryItemListLoadedState).inventoryItems,
          item
        ],
      );
    }
  }
}

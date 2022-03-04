import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class InventoryItemListNotifier extends StateNotifier<InventoryItemListState> {
  InventoryItemListNotifier() : super(InventoryItemListInitialState());

  Future<void> getAllInventoryItems() async {
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

  void removeItemFromState(String id) {
    if (state is InventoryItemListLoadedState) {
      final currentState = state as InventoryItemListLoadedState;
      List<InventoryItem> items =
          currentState.inventoryItems.where((item) => item.id != id).toList();
      state = InventoryItemListLoadedState(inventoryItems: items);
    }
  }

  void editItemInState(String id, EditInventoryItemRequest request) {
    if (state is InventoryItemListLoadedState) {
      final currentState = state as InventoryItemListLoadedState;
      List<InventoryItem> items = currentState.inventoryItems.map((item) {
        if (item.id != id) return item;
        item.name = request.name ?? item.name;
        item.description = request.description ?? item.description;
        item.amount = request.amount ?? item.amount;
        item.price = request.price ?? item.price;
        item.imageLink = request.imageLink ?? item.imageLink;
        return item;
      }).toList();
      state = InventoryItemListLoadedState(inventoryItems: items);
    }
  }
}

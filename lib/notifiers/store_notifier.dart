import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/states/store_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class StoreNotifier extends StateNotifier<StoreState> {
  StoreNotifier() : super(StoreInitialState());

  Future<void> getAllStoreItemsFromAllStores() async {
    state = StoreLoadingState();
    final response =
        await GetIt.I<Repository>().getAllStoreItemsFromAllStores();
    response.fold(
      (failure) => state = StoreErrorState(failure: failure),
      (storeItems) => state = StoreLoadedState(storeItems: storeItems),
    );
  }

  StoreItem? getItemFromState(String id) {
    if (state is! StoreLoadedState) return null;
    final currentState = state as StoreLoadedState;
    if (!currentState.storeItems.any((it) => it.id == id)) return null;
    return currentState.storeItems.firstWhere((it) => it.id == id);
  }

  void decrementAmountofItemInState(String id, int amount) {
    if (state is! StoreLoadedState) return;
    final currentState = state as StoreLoadedState;
    List<StoreItem> updatedItems = currentState.storeItems.map((item) {
      if (item.id != id) return item;
      item.amount -= amount;
      return item;
    }).toList();
    // remove item from the list if it is out of stock
    updatedItems.retainWhere((item) => item.amount > 0);
    state = StoreLoadedState(storeItems: updatedItems);
  }
}

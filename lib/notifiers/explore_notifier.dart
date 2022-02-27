import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/states/explore_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class ExploreNotifier extends StateNotifier<ExploreState> {
  ExploreNotifier() : super(ExploreInitialState());

  Future<void> getAllStoreItemsFromAllStores() async {
    state = ExploreLoadingState();
    final response =
        await GetIt.I<Repository>().getAllStoreItemsFromAllStores();
    response.fold(
      (failure) => state = ExploreErrorState(failure: failure),
      (storeItems) => state = ExploreLoadedState(storeItems: storeItems),
    );
  }

  StoreItem? getItemFromState(String id) {
    if (state is! ExploreLoadedState) return null;
    final currentState = state as ExploreLoadedState;
    if (!currentState.storeItems.any((it) => it.id == id)) return null;
    return currentState.storeItems.firstWhere((it) => it.id == id);
  }

  void decrementAmountofItemInState(String id, int amount) {
    if (state is! ExploreLoadedState) return;
    final currentState = state as ExploreLoadedState;
    List<StoreItem> updatedItems = currentState.storeItems.map((item) {
      if (item.id != id) return item;
      item.amount -= amount;
      return item;
    }).toList();
    // remove item from the list if it is out of stock
    updatedItems.retainWhere((item) => item.amount > 0);
    state = ExploreLoadedState(storeItems: updatedItems);
  }

  List<StoreItem> getItemsOfParticularStoreFromState(String storeName) {
    if (state is! ExploreLoadedState) return [];
    final currentState = state as ExploreLoadedState;
    return currentState.storeItems
        .where((item) => item.storeName == storeName)
        .toList();
  }

  List<StoreItem> searchItemsInState(String term) {
    if (state is! ExploreLoadedState) return [];
    final currentState = state as ExploreLoadedState;
    return currentState.storeItems
        .where((item) => item.name.startsWith(term))
        .toList();
  }
}

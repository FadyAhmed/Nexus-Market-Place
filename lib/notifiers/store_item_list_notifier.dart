import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/states/store_items_list_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class StoreItemListNotifier extends StateNotifier<StoreItemListState> {
  StoreItemListNotifier() : super(StoreItemListInitialState());

  void getAllStoreItemsFromMyStore() async {
    state = StoreItemListLoadingState();
    final response = await GetIt.I<Repository>().getAllStoreItemsFromMyStore();
    response.fold(
      (failure) => state = StoreItemListErrorState(failure: failure),
      (storeItems) => state = StoreItemListLoadedState(storeItems: storeItems),
    );
  }

  void addStoreItemToState(StoreItem item) {
    if (state is StoreItemListLoadedState) {
      state = (state as StoreItemListLoadedState).copyWith(
        storeItems: [...(state as StoreItemListLoadedState).storeItems, item],
      );
    }
  }

  void removeItemFromState(String id) {
    if (state is StoreItemListLoadedState) {
      final currentState = state as StoreItemListLoadedState;
      List<StoreItem> items =
          currentState.storeItems.where((item) => item.id != id).toList();
      state = StoreItemListLoadedState(storeItems: items);
    }
  }

  void editItemInState(String id, EditStoreItemRequest request) {
    if (state is StoreItemListLoadedState) {
      final currentState = state as StoreItemListLoadedState;
      List<StoreItem> items = currentState.storeItems.map((item) {
        if (item.id != id) return item;
        item.name = request.name ?? item.name;
        item.description = request.description ?? item.description;
        item.amount = request.amount ?? item.amount;
        item.price = request.price ?? item.price;
        item.imageLink = request.imageLink ?? item.imageLink;
        return item;
      }).toList();
      state = StoreItemListLoadedState(storeItems: items);
    }
  }
}

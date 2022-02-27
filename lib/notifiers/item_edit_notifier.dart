import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class ItemEditNotifier extends StateNotifier<ItemEditState> {
  AutoDisposeStateNotifierProviderRef ref;

  ItemEditNotifier(this.ref) : super(ItemEditInitialState());

  void addInventoryItem(AddInventoryItemRequest request) async {
    state = ItemEditLoadingState();
    final response = await GetIt.I<Repository>().addInventoryItem(request);
    response.fold(
      (failure) => state = ItemEditErrorState(failure: failure),
      (item) {
        ref
            .read(inventoryItemsListProvider.notifier)
            .addInventoryItemToState(item);
        state = ItemEditLoadedState();
      },
    );
  }

  void editInventoryItem(String id, EditInventoryItemRequest request) async {
    state = ItemEditLoadingState();
    final response = await GetIt.I<Repository>().editInventoryItem(id, request);
    response.fold(
      (failure) => state = ItemEditErrorState(failure: failure),
      (_) {
        ref
            .read(inventoryItemsListProvider.notifier)
            .editItemInState(id, request);
        state = ItemEditLoadedState();
      },
    );
  }

  void addItemInMyInventoryToMyStore(
      String id, AddItemInMyInventoryToMyStoreRequest request) async {
    state = ItemEditLoadingState();
    final response =
        await GetIt.I<Repository>().addItemInMyInventoryToMyStore(id, request);
    response.fold(
      (failure) => state = ItemEditErrorState(failure: failure),
      (item) {
        ref.read(storeItemsListProvider.notifier).addStoreItemToState(item);
        ref.read(exploreProvider.notifier).addStoreItemToState(item);
        state = ItemEditLoadedState();
      },
    );
  }

  void editStoreItem(String id, EditStoreItemRequest request) async {
    state = ItemEditLoadingState();
    final response = await GetIt.I<Repository>().editStoreItem(id, request);
    response.fold(
      (failure) => state = ItemEditErrorState(failure: failure),
      (_) {
        ref.read(storeItemsListProvider.notifier).editItemInState(id, request);
        ref.read(exploreProvider.notifier).editItemInState(id, request);
        state = ItemEditLoadedState();
      },
    );
  }

  void addItemInOtherStoreToMyStore(String id) async {
    state = ItemEditLoadingState();
    final response = await GetIt.I<Repository>().addItemInOtherStoreToMyStore(
      id,
    );
    response.fold(
      (failure) => state = ItemEditErrorState(failure: failure),
      (item) {
        ref.read(storeItemsListProvider.notifier).addStoreItemToState(item);
        state = ItemEditLoadedState();
      },
    );
  }
}

import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/add_inventory_item_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

class AddInventoryItemNotifier extends StateNotifier<AddInventoryItemState> {
  StateNotifierProviderRef ref;

  AddInventoryItemNotifier(this.ref) : super(AddInventoryItemInitialState());

  void addInventoryItem(AddInventoryItemRequest request) async {
    state = AddInventoryItemLoadingState();
    final response = await GetIt.I<Repository>().addInventoryItem(request);
    response.fold(
      (failure) => state = AddInventoryItemErrorState(failure: failure),
      (item) {
        ref
            .read(inventoryItemsListProvider.notifier)
            .addInventoryItemToState(item);
        state = AddInventoryItemLoadedState();
      },
    );
  }
}

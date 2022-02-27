import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/notifiers/explore_notifier.dart';
import 'package:ds_market_place/notifiers/item_edit_notifier.dart';
import 'package:ds_market_place/notifiers/item_delete_notifier.dart';
import 'package:ds_market_place/notifiers/inventory_items_list_notifier.dart';
import 'package:ds_market_place/notifiers/purchase_notifier.dart';
import 'package:ds_market_place/notifiers/store_item_list_notifier.dart';
import 'package:ds_market_place/states/explore_state.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:ds_market_place/states/purchase_state.dart';
import 'package:ds_market_place/states/store_items_list_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';

final inventoryItemsListProvider =
    StateNotifierProvider<InventoryItemListNotifier, InventoryItemListState>(
        (ref) => InventoryItemListNotifier());

final itemEditProvider =
    StateNotifierProvider.autoDispose<ItemEditNotifier, ItemEditState>(
        (ref) => ItemEditNotifier(ref));

final itemDeleteProvider =
    StateNotifierProvider.autoDispose<ItemDeleteNotifier, ItemDeleteState>(
        (ref) => ItemDeleteNotifier(ref));

final storeItemsListProvider =
    StateNotifierProvider<StoreItemListNotifier, StoreItemListState>(
        (ref) => StoreItemListNotifier());

final exploreProvider = StateNotifierProvider<ExploreNotifier, ExploreState>(
    (ref) => ExploreNotifier());

final purchaseProvider =
    StateNotifierProvider.autoDispose<PurchaseNotifier, PurchaseState>(
        (ref) => PurchaseNotifier(ref));

final accountInfoProvider = FutureProvider.autoDispose<Profile>((ref) async {
  final response = await GetIt.I<RestClient>().getProfile();
  return response.profile;
});

final notSoldItemsProvider =
    FutureProvider.autoDispose<List<StoreItem>>((ref) async {
  final response = await GetIt.I<RestClient>().getAllStoreItemsFromMyStore();
  return response.storeItems
      .where((item) => item.state == StoreItemState.owned)
      .toList();
});

final soldItemsProvider =
    FutureProvider.autoDispose<List<Transaction>>((ref) async {
  final response = await GetIt.I<RestClient>().getMySoldItems();
  return response.transactions;
});

final purchasedItemsProvider =
    FutureProvider.autoDispose<List<Transaction>>((ref) async {
  final response = await GetIt.I<RestClient>().getMyPurchasedItems();
  return response.transactions;
});

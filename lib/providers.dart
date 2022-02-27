import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/notifiers/item_edit_notifier.dart';
import 'package:ds_market_place/notifiers/item_delete_notifier.dart';
import 'package:ds_market_place/notifiers/inventory_items_list_notifier.dart';
import 'package:ds_market_place/notifiers/store_item_list_notifier.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:ds_market_place/states/store_items_list_state.dart';
import 'package:riverpod/riverpod.dart';

final inventoryItemsListProvider =
    StateNotifierProvider<InventoryItemListNotifier, InventoryItemListState>(
        (ref) => InventoryItemListNotifier());
        
final itemEditProvider = StateNotifierProvider<ItemEditNotifier, ItemEditState>(
    (ref) => ItemEditNotifier(ref));
        
final itemsDeleteProvider =
    StateNotifierProvider<ItemDeleteNotifier, ItemDeleteState>(
        (ref) => ItemDeleteNotifier(ref));

final storeItemsListProvider =
    StateNotifierProvider<StoreItemListNotifier, StoreItemListState>(
        (ref) => StoreItemListNotifier());

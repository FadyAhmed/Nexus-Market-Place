import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/notifiers/inventory_item_edit_notifier.dart';
import 'package:ds_market_place/notifiers/delete_inventory_item_notifier.dart';
import 'package:ds_market_place/notifiers/inventory_items_list_notifier.dart';
import 'package:ds_market_place/states/inventory_item_edit_state.dart';
import 'package:ds_market_place/states/inventory_item_delete_state.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:riverpod/riverpod.dart';

final inventoryItemsListProvider =
    StateNotifierProvider<InventoryItemListNotifier, InventoryItemListState>(
        (ref) => InventoryItemListNotifier());
final inventoryItemsEditProvider =
    StateNotifierProvider<InventoryItemEditNotifier, InventoryItemEditState>(
        (ref) => InventoryItemEditNotifier(ref));
final inventoryItemsDeleteProvider = StateNotifierProvider<
    InventoryItemDeleteNotifier,
    InventoryItemDeleteState>((ref) => InventoryItemDeleteNotifier(ref));

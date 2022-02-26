import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/notifiers/add_inventory_item_notifier.dart';
import 'package:ds_market_place/notifiers/inventory_items_list_notifier.dart';
import 'package:ds_market_place/states/add_inventory_item_state.dart';
import 'package:ds_market_place/states/inventory_items_list_state.dart';
import 'package:riverpod/riverpod.dart';

final inventoryItemsListProvider =
    StateNotifierProvider<InventoryItemListNotifier, InventoryItemListState>(
        (ref) => InventoryItemListNotifier());
final addInventoryItemsProvider =
    StateNotifierProvider<AddInventoryItemNotifier, AddInventoryItemState>(
        (ref) => AddInventoryItemNotifier(ref));

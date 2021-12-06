import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/services/inventories_web_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class InventoriesProvider with ChangeNotifier {
  var inventoriesWebService = InventoriesWebService(http.Client());

  LoadingStatus loadingStatus = LoadingStatus.done;

  List<InventoryItem>? items;

  Future<void> addItem(InventoryItem item) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      String itemId = await inventoriesWebService.addItem(item);
      item.id = itemId;
      items!.add(item);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<InventoryItem>> getAllItems({notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      List<InventoryItem> fetchedItems =
          await inventoriesWebService.getAllItems();
      items = fetchedItems;
      return fetchedItems;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<InventoryItem> getItemById(String id,
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      InventoryItem item = await inventoriesWebService.getItemById(id);
      return item;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> editItem(InventoryItem item) async {
    assert(item.id != null);
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await inventoriesWebService.editItem(item);
      int index = items!.indexWhere((it) => it.id == item.id);
      items!.removeAt(index);
      items!.insert(index, item);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> removeItem(String id) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await inventoriesWebService.removeItem(id);
      items!.removeWhere((it) => it.id == id);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

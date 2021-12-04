import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:flutter/cupertino.dart';

class StoresProvider with ChangeNotifier {
  StoresWebService storesWebService = StoresWebService();

  LoadingStatus loadingStatus = LoadingStatus.done;
  LoadingStatus purchaseLoadingStatus = LoadingStatus.done;
  LoadingStatus addToMyStoreLoadingStatus = LoadingStatus.done;

  List<StoreItem>? items;
  List<StoreItem>? allItems;
  List<StoreItem>? storeItems;
  List<StoreItem>? searchItems;

  Future<List<StoreItem>> getAllItemsFromMyStore(
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      List<StoreItem> fetchedItems =
          await storesWebService.getAllItemsFromMyStore();
      items = fetchedItems;
      return fetchedItems;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<StoreItem> getItemFromMyStore(String id,
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      StoreItem item = await storesWebService.getItemFromMyStore(id);
      return item;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> addInventoryItemToMyStore({
    required String id,
    required int amount,
    required double price,
  }) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      String itemId = await storesWebService.addInventoryItemToMyStore(
        id: id,
        amount: amount,
        price: price,
      );
      // get the store item
      StoreItem item = await storesWebService.getItemFromMyStore(itemId);
      items!.add(item);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<StoreItem> addAnotherStoreItemToMyStore(String id) async {
    addToMyStoreLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      StoreItem item = await storesWebService.addAnotherStoreItemToMyStore(id);
      items!.add(item);
      return item;
    } catch (e) {
      throw e;
    } finally {
      addToMyStoreLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> removeItemFromMyStore(String id) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await storesWebService.removeItemFromMyStore(id);
      items!.removeWhere((it) => it.id == id);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> editItemInMyStore(StoreItem item) async {
    assert(item.id != null);
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await storesWebService.editItemInMyStore(item);
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

  Future<List<StoreItem>> getAllItemsFromAllStores(
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      List<StoreItem> fetchedItems =
          await storesWebService.getAllItemsFromAllStores();
      allItems = fetchedItems;
      return fetchedItems;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<StoreItem>> getAllItemsOfAParticularStore(String id,
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      List<StoreItem> fetchedItems =
          await storesWebService.getAllItemsOfAParticularStore(id);
      storeItems = fetchedItems;
      return fetchedItems;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<StoreItem>> searchAllStores(String searchTerm,
      {notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      List<StoreItem> fetchedItems =
          await storesWebService.searchAllStores(searchTerm);
      searchItems = fetchedItems;
      return fetchedItems;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  void clearSearchItems() => searchItems = null;

  Future<String> purchaseItem(String id, int amount) async {
    purchaseLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      String itemId = await storesWebService.purchaseItem(id, amount);
      // update stored storeItem (alternatively we could receive the new store item from the back end)
      if (allItems != null && allItems!.any((item) => item.id == id))
        allItems!.firstWhere((item) => item.id == id).amount -= amount;
      if (storeItems != null && storeItems!.any((item) => item.id == id))
        storeItems!.firstWhere((item) => item.id == id).amount -= amount;
      if (searchItems != null && searchItems!.any((item) => item.id == id))
        searchItems!.firstWhere((item) => item.id == id).amount -= amount;
      return itemId;
    } finally {
      purchaseLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

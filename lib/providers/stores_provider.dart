import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:flutter/cupertino.dart';

class StoresProvider with ChangeNotifier {
  StoresWebService storesWebService = StoresWebService();

  LoadingStatus loadingStatus = LoadingStatus.done;

  List<StoreItem>? items;

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

}

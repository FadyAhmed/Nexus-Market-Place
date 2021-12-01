import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/services/inventories_web_service.dart';
import 'package:flutter/cupertino.dart';

class InventoriesProvider with ChangeNotifier {
  var inventoriesWebService = InventoriesWebService();

  LoadingStatus loadingStatus = LoadingStatus.done;

  Future<void> addItem(InventoryItem item) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await inventoriesWebService.addItem(item);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

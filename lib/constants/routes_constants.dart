class RoutesConstants {
  static String baseUrl = 'https://nexus-market.herokuapp.com/api';

// USERS API
  static String usersBaseUrl = RoutesConstants.baseUrl + '/users';

  static String signIn = RoutesConstants.usersBaseUrl + '/login';
  static String signUp = RoutesConstants.usersBaseUrl + '/signup';
  static String getMyProfile = RoutesConstants.usersBaseUrl + '/profile';
  static String getAllUsers = RoutesConstants.usersBaseUrl;
  static String addBalance = RoutesConstants.usersBaseUrl + '/wallet/deposit';
  static String removeBalance =
      RoutesConstants.usersBaseUrl + '/wallet/withdraw';

  // INVENTORIES API
  static String addItemToInventory = RoutesConstants.baseUrl + '/myinventory';
  static String getAllInventoryItems = RoutesConstants.baseUrl + '/myinventory';
  static String getInventoryItemById(String id) =>
      RoutesConstants.baseUrl + '/myinventory/' + id;
  static String editInventoryItem(String id) =>
      RoutesConstants.baseUrl + '/myinventory/' + id;
  static String removeInventoryItem(String id) =>
      RoutesConstants.baseUrl + '/myinventory/' + id;

  // STORES API
  static String storesBaseUrl = RoutesConstants.baseUrl + '/stores';

  static String getAllItemsFromMyStore =
      RoutesConstants.storesBaseUrl + '/mystore';
  static String getItemFromMyStore(String id) =>
      RoutesConstants.storesBaseUrl + '/mystore/' + id;
  static String addInventoryItemToMyStore(String id) =>
      RoutesConstants.storesBaseUrl + '/mystore/' + id;
  static String addAnotherStoreItemToMyStore(String id) =>
      RoutesConstants.storesBaseUrl + '/add/' + id;
  static String removeItemFromMyStore(String id) =>
      RoutesConstants.storesBaseUrl + '/mystore/' + id;
}

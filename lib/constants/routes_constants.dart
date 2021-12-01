class RoutesConstants {
  static String baseUrl = 'https://nexus-market.herokuapp.com/api';

  static String usersBaseUrl = RoutesConstants.baseUrl + '/users';

  static String signIn = RoutesConstants.usersBaseUrl + '/login';
  static String signUp = RoutesConstants.usersBaseUrl + '/signup';
  static String getMyProfile = RoutesConstants.usersBaseUrl + '/profile';
  static String getAllUsers = RoutesConstants.usersBaseUrl;
  static String addBalance = RoutesConstants.usersBaseUrl + '/wallet/deposit';
  static String removeBalance =
      RoutesConstants.usersBaseUrl + '/wallet/withdraw';

  static String addItemToInventory = RoutesConstants.baseUrl + '/myinventory';
}

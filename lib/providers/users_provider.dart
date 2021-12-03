import 'package:ds_market_place/models/add_balance_request.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/services/users_web_service.dart';

class UsersProvider with ChangeNotifier {
  UsersWebService usersWebService = UsersWebService();

  LoadingStatus profileLoadingStatus = LoadingStatus.initial;
  LoadingStatus usersLoadingStatus = LoadingStatus.initial;
  LoadingStatus balanceLoadingStatus = LoadingStatus.initial;

  Profile? profile;
  List<User>? users;

  Future<Profile> getMyProfile({notifyWhenLoaded = true}) async {
    profileLoadingStatus = LoadingStatus.loading;
    if (notifyWhenLoaded) notifyListeners();

    try {
      Profile fetchedProfile = await usersWebService.getMyProfile();
      profile = fetchedProfile;
      return fetchedProfile;
    } catch (e) {
      throw e;
    } finally {
      profileLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<List<User>> getAllUsers({notifyWhenLoaded = true}) async {
    usersLoadingStatus = LoadingStatus.loading;
    if (notifyWhenLoaded) notifyListeners();

    try {
      users = await usersWebService.getAllUsers();
      return users!;
    } catch (e) {
      throw e;
    } finally {
      usersLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> addBalance(AddBalanceRequest addBalanceRequest) async {
    balanceLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await usersWebService.addBalance(addBalanceRequest);
      profile!.balance += addBalanceRequest.amount;
    } catch (e) {
      throw e;
    } finally {
      balanceLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<void> removeBalance(AddBalanceRequest addBalanceRequest) async {
    balanceLoadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await usersWebService.removeBalance(addBalanceRequest);
      profile!.balance -= addBalanceRequest.amount;
    } catch (e) {
      throw e;
    } finally {
      balanceLoadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

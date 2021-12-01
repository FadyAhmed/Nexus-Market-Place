import 'package:flutter/cupertino.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/services/users_web_service.dart';

class UsersProvider with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.initial;
  UsersWebService usersWebService = UsersWebService();

  Future<Profile> getMyProfile({notifyWhenLoaded = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoaded) notifyListeners();

    Profile profile = await usersWebService.getMyProfile();
    loadingStatus = LoadingStatus.done;
    notifyListeners();
    return profile;
  }
}

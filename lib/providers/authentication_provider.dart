import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/login.dart';
import 'package:ds_market_place/models/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/authentication_model.dart';
import 'package:ds_market_place/services/authentication_web_service.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationWebService authenticationWebService;
  AuthenticationModel? authenticationModel;
  LoadingStatus loadingStatus = LoadingStatus.initial;

  AuthenticationProvider({required this.authenticationWebService});

  String? get token => authenticationModel?.token;

  Future<void> signIn(Login loginData, {bool notifyWhenLoading = true}) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    try {
      await authenticationWebService.signIn(loginData);
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }

  Future<bool> signUp(Signup signupData) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    try {
      await authenticationWebService.signUp(signupData);
      return true;
    } catch (e) {
      throw e;
    } finally {
      loadingStatus = LoadingStatus.done;
      notifyListeners();
    }
  }
}

import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/exceptions.dart';
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

  Future<void> signIn(
    String email,
    String password, {
    bool notifyWhenLoading = true,
  }) async {
    loadingStatus = LoadingStatus.loading;
    if (notifyWhenLoading) notifyListeners();

    authenticationModel =
        await authenticationWebService.signIn(email, password);
    globals.token = authenticationModel?.token;
    loadingStatus = LoadingStatus.done;
    notifyListeners();
  }

  Future<bool> signUp(Signup signupData) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    await authenticationWebService.signUp(signupData);
    loadingStatus = LoadingStatus.done;
    notifyListeners();
    return true;
  }
}

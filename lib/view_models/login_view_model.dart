import 'dart:async';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:get_it/get_it.dart';



class LoginViewModel {
  Repository repository = GetIt.instance();

  StreamController<ScreenStatus> screenStatusStreamController =
      StreamController<ScreenStatus>.broadcast();
  StreamController<Failure?> failureStreamController =
      StreamController<Failure?>.broadcast();
  StreamController<bool> isUserLoggedInController =
      StreamController<bool>.broadcast();

  void start() {
    screenStatusStreamController.add(ScreenStatus.content);
  }

  void dispose() {
    screenStatusStreamController.close();
    failureStreamController.close();
    isUserLoggedInController.close();
  }

  void signIn(LoginRequest loginRequest) async {
    screenStatusStreamController.add(ScreenStatus.loading);
    final response = await repository.signIn(LoginRequest(
        username: loginRequest.username, password: loginRequest.password));
    response.fold(
      (failure) {
        screenStatusStreamController.add(ScreenStatus.error);
        failureStreamController.add(failure);
      },
      (_) {
        screenStatusStreamController.add(ScreenStatus.content);
        isUserLoggedInController.add(true);
      },
    );
  }
}
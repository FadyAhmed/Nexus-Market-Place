import 'dart:async';

import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SignUpViewModel {
  Repository repository = GetIt.instance();

  BehaviorSubject<bool> loadingController = BehaviorSubject<bool>();
  BehaviorSubject<Failure?> failureController = BehaviorSubject<Failure?>();
  BehaviorSubject<bool> isSignedUpController = BehaviorSubject<bool>();

  Future<void> signUp(SignUpRequest request) async {
    clearFailure();
    loadingController.add(true);
    final response = await repository.signUp(request);
    response.fold(
      (failure) {
        loadingController.add(false);
        failureController.add(failure);
        failureController.add(null); // clear flag
      },
      (_) {
        loadingController.add(false);
        isSignedUpController.add(true);
        isSignedUpController.add(false); // clear
      },
    );
  }

  void clearFailure() {
    failureController.add(null);
  }
}

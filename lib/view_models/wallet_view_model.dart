import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class WalletViewModel {
  BehaviorSubject<bool> profileLoadingController = BehaviorSubject();
  BehaviorSubject<bool> balanceLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<double> balanceController = BehaviorSubject();
  BehaviorSubject<bool?> snackBarController = BehaviorSubject();

  double? balance;

  void setBalance(double balance) {
    this.balance = balance;
    balanceController.add(balance);
  }

  Future<void> addBalance(AddBalanceRequest request) async {
    clearFailure();
    balanceLoadingController.add(true);
    final response = await GetIt.I<Repository>().addBalance(request);
    response.fold(
      (failure) {
        balanceLoadingController.add(false);
        failureController.add(failure);
        failureController.add(null); //clear flag
      },
      (_) {
        balance = balance! + request.amount;
        balanceController.add(balance!);
        balanceLoadingController.add(false);
        snackBarController.add(true);
      },
    );
  }

  Future<void> removeBalance(RemoveBalanceRequest request) async {
    clearFailure();
    balanceLoadingController.add(true);
    final response = await GetIt.I<Repository>().removeBalance(request);
    response.fold(
      (failure) {
        balanceLoadingController.add(false);
        failureController.add(failure);
        failureController.add(null); //clear flag
      },
      (_) {
        balance = balance! - request.amount;
        balanceController.add(balance!);
        balanceLoadingController.add(false);
        snackBarController.add(false);
      },
    );
  }

  Future<void> getBalance() async {
    clearFailure();
    profileLoadingController.add(true);
    final response = await GetIt.I<Repository>().getProfile();
    response.fold(
      (failure) {
        profileLoadingController.add(false);
        failureController.add(failure);
      },
      (Profile profile) {
        balance = profile.balance;
        balanceController.add(balance!);
        profileLoadingController.add(false);
      },
    );
  }

  void clearFailure() {
    failureController.add(null);
  }

  void clearSnackBar() {
    failureController.add(null);
  }
}

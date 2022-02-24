import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class UsersReportsViewModel {
  BehaviorSubject<bool> loadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<List<User>> usersController = BehaviorSubject();

  List<User>? users;

  Future<void> getAllUsers() async {
    clearFailure();
    loadingController.add(true);
    final response = await GetIt.I<Repository>().getAllUsers();
    response.fold(
      (failure) {
        loadingController.add(false);
        failureController.add(failure);
      },
      (List<User> users) {
        this.users = users;
        usersController.add(users);
        loadingController.add(false);
      },
    );
  }

  void clearFailure() {
    failureController.add(null);
  }
}

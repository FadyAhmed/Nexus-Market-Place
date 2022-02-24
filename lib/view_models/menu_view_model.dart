import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class MenuViewModel {
  BehaviorSubject<bool> gettingLoadingController = BehaviorSubject();
  BehaviorSubject<Failure?> failureController = BehaviorSubject();
  BehaviorSubject<Profile> profileController = BehaviorSubject();

  Profile? profile;

  Future<void> getProfile() async {
    clearFailure();
    gettingLoadingController.add(true);
    final response = await GetIt.I<Repository>().getProfile();
    response.fold(
      (failure) {
        gettingLoadingController.add(false);
        failureController.add(failure);
      },
      (Profile profile) {
        this.profile = profile;
        profileController.add(profile);
        gettingLoadingController.add(false);
      },
    );
  }

  void clearFailure() {
    failureController.add(null);
  }
}

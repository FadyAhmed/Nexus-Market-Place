import 'package:dio/dio.dart';
import 'package:ds_market_place/app/dio_factory.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/add_inventory_item_view_model.dart';
import 'package:ds_market_place/view_models/edit_inventory_item_view_model.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/item_details_view_model.dart';
import 'package:ds_market_place/view_models/login_view_model.dart';
import 'package:get_it/get_it.dart';

Future<void> injectDependencies() async {
  GetIt instance = GetIt.instance;

  instance.registerLazySingleton<Dio>(() => getDio);
  instance.registerLazySingleton<RestClient>(() => RestClient(instance()));
  instance.registerLazySingleton<Repository>(() => Repository(instance()));

  instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  instance
      .registerLazySingleton<InventoryViewModel>(() => InventoryViewModel());
  instance.registerLazySingleton<EditInventoryItemViewModel>(
      () => EditInventoryItemViewModel());
  instance.registerLazySingleton<ItemDetailsViewModel>(
      () => ItemDetailsViewModel());
  instance.registerLazySingleton<AddInventoryItemViewModel>(
      () => AddInventoryItemViewModel());
}

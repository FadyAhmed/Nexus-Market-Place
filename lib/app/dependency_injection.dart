import 'package:dio/dio.dart';
import 'package:ds_market_place/app/dio_factory.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:ds_market_place/view_models/account_info_view_model.dart';
import 'package:ds_market_place/view_models/add_inventory_item_view_model.dart';
import 'package:ds_market_place/view_models/confirm_to_sell_item_view_model.dart';
import 'package:ds_market_place/view_models/edit_item_view_model.dart';
import 'package:ds_market_place/view_models/explore_view_model.dart';
import 'package:ds_market_place/view_models/inventory_view_model.dart';
import 'package:ds_market_place/view_models/item_details_view_model.dart';
import 'package:ds_market_place/view_models/login_view_model.dart';
import 'package:ds_market_place/view_models/menu_view_model.dart';
import 'package:ds_market_place/view_models/purchase_view_model.dart';
import 'package:ds_market_place/view_models/transactions_reports_view_model.dart';
import 'package:ds_market_place/view_models/user_reports_view_model.dart';
import 'package:ds_market_place/view_models/search_view_model.dart';
import 'package:ds_market_place/view_models/select_item_to_sell_view_model.dart';
import 'package:ds_market_place/view_models/signup_view_model.dart';
import 'package:ds_market_place/view_models/store_details_view_model.dart';
import 'package:ds_market_place/view_models/store_view_model.dart';
import 'package:ds_market_place/view_models/wallet_view_model.dart';
import 'package:get_it/get_it.dart';

Future<void> injectDependencies() async {
  GetIt instance = GetIt.instance;

  instance.registerLazySingleton<Dio>(() => getDio);
  instance.registerLazySingleton<RestClient>(() => RestClient(instance()));
  instance.registerLazySingleton<Repository>(() => Repository(instance()));

  instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  instance
      .registerLazySingleton<InventoryViewModel>(() => InventoryViewModel());
  instance.registerLazySingleton<EditItemViewModel>(() => EditItemViewModel());
  instance.registerLazySingleton<ItemDetailsViewModel>(
      () => ItemDetailsViewModel());
  instance.registerLazySingleton<AddInventoryItemViewModel>(
      () => AddInventoryItemViewModel());
  instance.registerLazySingleton<StoreViewModel>(() => StoreViewModel());
  instance.registerLazySingleton<SelectItemToSellViewModel>(
      () => SelectItemToSellViewModel());
  instance.registerLazySingleton<ConfirmToSellItemViewModel>(
      () => ConfirmToSellItemViewModel());
  instance.registerLazySingleton<ExploreViewModel>(() => ExploreViewModel());
  instance.registerLazySingleton<StoreDetailsViewModel>(
      () => StoreDetailsViewModel());
  instance.registerLazySingleton<SearchViewModel>(() => SearchViewModel());
  instance.registerLazySingleton<AccountInfoViewModel>(
      () => AccountInfoViewModel());
  instance.registerLazySingleton<MenuViewModel>(() => MenuViewModel());
  instance.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  instance.registerLazySingleton<UsersReportsViewModel>(
      () => UsersReportsViewModel());
  instance.registerLazySingleton<TransactionReportsViewModel>(
      () => TransactionReportsViewModel());
  instance.registerLazySingleton<WalletViewModel>(() => WalletViewModel());

  
  instance.registerFactory<PurchaseViewModel>(() => PurchaseViewModel());
}

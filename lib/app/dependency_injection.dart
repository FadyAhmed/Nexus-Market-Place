import 'package:dio/dio.dart';
import 'package:ds_market_place/app/dio_factory.dart';
import 'package:ds_market_place/data/rest_client.dart';
import 'package:ds_market_place/domain/repository.dart';
import 'package:get_it/get_it.dart';

Future<void> injectDependencies() async {
  GetIt instance = GetIt.instance;

  instance.registerLazySingleton<Dio>(() => getDio);
  instance.registerLazySingleton<RestClient>(() => RestClient(instance()));
  instance.registerLazySingleton<Repository>(() => Repository(instance()));
}

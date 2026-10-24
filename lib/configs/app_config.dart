import 'package:get_it/get_it.dart';
import 'package:product_catalog_application/configs/network/api_calling.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiCalling>(() => ApiCalling());
}
import 'package:get_it/get_it.dart';

import '../../core/network/dio_client.dart';
import '../data/remote/product/product_api.dart';
import '../data/repository/product/product_repositories.dart';

final GetIt getIt = GetIt.instance;

void serviceLocator() {
  getIt.registerSingleton<DioClient>(DioClient());

  //product api & repository
  getIt.registerSingleton<ApiService>(ApiService(getIt<DioClient>()));
  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt<ApiService>()));

} 

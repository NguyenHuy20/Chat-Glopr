import 'package:chat_glopr/@core/network/repository/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'network/api_client.dart';

GetIt inject = GetIt.instance;

void initDependence() {
  inject.registerLazySingleton(() => ApiClient());
  inject.registerFactory<AuthRepo>(() => AuthRepo());
}

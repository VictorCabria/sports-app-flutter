////import 'package:appsflyer_sdk/appsflyer_sdk.dart';

import 'package:deporte_app_flutter/di/data_local.dart';
import 'package:deporte_app_flutter/di/local.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../repository/app_configuration_service_impl.dart';
import '../repository/local_service_impl.dart';
import '../routes/routes_navigator_service.dart';
import '../routes/routes_navigator_service_impl.dart';
import '../view_model/home_view_model.dart';
import '../view_model/initial_loading_view_model.dart';
import '../view_model/splah_screen_view_model.dart';

final getIt = GetIt.instance;

Future<void> initializeDI() async {
  _domain();
  _data();
  _view();
}

void _data() async {
  http.Client _client = http.Client();
  getIt.registerSingleton<http.Client>(_client);
  getIt.registerSingleton<GetStorage>(GetStorage());
  getIt.registerSingleton<Local>(DataLocal(getIt()));
  getIt.registerSingleton<LocalService>(LocalServiceImpl(getIt.get<Local>()));
  /* getIt.registerSingleton<AppsflyerSdk>(appsflyerSdk); */

  getIt.registerSingleton<RoutesNavigatorService>(
      RoutesNavigatorServiceImpl(getIt()));
}

void _domain() async {
  // load config.json file and register the values
  getIt.registerSingleton<AppConfigurationService>(
      AppConfigurationServiceImpl());
  // initialize the app configuration service
  await getIt.get<AppConfigurationService>().init("lib/config.json");
}

void _view() async {
  getIt.registerFactory<InitialLoadingViewModel>(
    () => InitialLoadingViewModel(
      getIt.get<RoutesNavigatorService>(),
    ),
  );
  getIt.registerFactory<SplashScreenViewModel>(
    () => SplashScreenViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<NewHomeViewModel>(
    () => NewHomeViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  // VIEW
}

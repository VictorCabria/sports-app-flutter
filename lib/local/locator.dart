import 'package:deporte_app_flutter/local/data_local.dart';
import 'package:deporte_app_flutter/local/local.dart';
import 'package:deporte_app_flutter/view_model/info_result_view_model.dart';
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
import '../view_model/league_info_view_model.dart';
import '../view_model/leagues_view_model.dart';
import '../view_model/image_show_view_model.dart';
import '../view_model/initial_loading_view_model.dart';
import '../view_model/login_view_model.dart';
import '../view_model/player_soccer_view_model.dart';
import '../view_model/results_view_model.dart';
import '../view_model/scorers_view_model.dart';
import '../view_model/splah_screen_view_model.dart';
import '../view_model/tabheadtohead_view_model.dart';
import '../view_model/tablineups_view_model.dart';
import '../view_model/tabpositions_view_model.dart';
import '../view_model/tabresult_view_model.dart';
import '../view_model/tabscorers_view_model.dart';
import '../view_model/tabstatistics_view_model.dart';
import '../view_model/user_profile_view_model.dart';

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

  getIt.registerFactory<LoginWidgetModel>(
    () => LoginWidgetModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
  getIt.registerFactory<NewLeaguesWidgetViewModel>(
    () => NewLeaguesWidgetViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<NewLeaguesInfoWidgetViewModel>(
    () => NewLeaguesInfoWidgetViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<NewHomeViewModel>(
    () => NewHomeViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<UserProfileModel>(
    () => UserProfileModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<ResultsModel>(
    () => ResultsModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<ScorersModel>(
    () => ScorersModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<ImageShowViewModel>(
    () => ImageShowViewModel(),
  );

  getIt.registerFactory<NewInforesultModel>(
    () => NewInforesultModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<PlayerSoccerViewModel>(
    () => PlayerSoccerViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );


  getIt.registerFactory<TabStatisticsViewModel>(
    () => TabStatisticsViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
  getIt.registerFactory<TabScorersViewModel>(
    () => TabScorersViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
  getIt.registerFactory<TabHeadToHeadViewModel>(
    () => TabHeadToHeadViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
  getIt.registerFactory<TabLineupsViewModel>(
    () => TabLineupsViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );

  getIt.registerFactory<TabResultViewModel>(
    () => TabResultViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
  getIt.registerFactory<TabPositionsViewModel>(
    () => TabPositionsViewModel(getIt.get<RoutesNavigatorService>(),
        getIt.get<LocalService>(), getIt.get<AppConfigurationService>()),
  );
}

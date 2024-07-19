import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/topscorers.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/topscorers_services.dart';

class TabScorersViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabScorersViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;
  final RxList<TopsScorers> _topsscorers = <TopsScorers>[].obs;

  //getters
  List<TopsScorers> get topsscorers => _topsscorers;
  @override
  initialize() {}

  void setresult(Fixtures? value) {
    fixtures = value;
    getresult(value);
  }

  void getresult(Fixtures? value) async {
    var results =
        await topsScorersServices.fetchtopscorets(value!.leagueKey.toString());
    _topsscorers.addAll(results);
  }
}

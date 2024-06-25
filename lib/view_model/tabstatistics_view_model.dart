import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class TabStatisticsViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabStatisticsViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;
  final RxString _homepossession = ''.obs;
  final RxString _awaypossession = ''.obs;

  //getters
  RxString get homepossession => _homepossession;
  RxString get awaypossession => _awaypossession;

  @override
  initialize() {}

  void setresult(Fixtures? value) {
    fixtures = value;
    ballPossession();
  }

  void ballPossession() {
    RxString homeposession = "".obs;
    RxString awayposession = "".obs;
    if (fixtures?.statistics != null) {
      for (var fix in fixtures!.statistics!) {
        if (fix.type == "Ball Possession") {
          homeposession.value = fix.home!;
          awayposession.value = fix.away!;
        }
      }
    }
    _homepossession.value = homeposession.value.replaceAll('%', '');
    _awaypossession.value = awayposession.value.replaceAll('%', '');
  }
}

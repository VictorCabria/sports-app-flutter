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
  final RxString _homecards = ''.obs;
  final RxString _awaycards = ''.obs;
  final RxString _homecardsred = ''.obs;
  final RxString _awaycardsred = ''.obs;
  final RxString _homecshots = ''.obs;
  final RxString _awayshots = ''.obs;
  final RxString _homeshotsongoal = ''.obs;
  final RxString _awayshotsongoal = ''.obs;
  final RxString _homeFouls = ''.obs;
  final RxString _awayFouls = ''.obs;
  final RxString _homecorners = ''.obs;
  final RxString _awaycorners = ''.obs;
  final RxString _homesaves = ''.obs;
  final RxString _awaysaves = ''.obs;

  //getters
  RxString get homepossession => _homepossession;
  RxString get awaypossession => _awaypossession;
  RxString get homecards => _homecards;
  RxString get awaycards => _awaycards;
  RxString get homecardsred => _homecardsred;
  RxString get awaycardsred => _awaycardsred;
  RxString get homecshots => _homecshots;
  RxString get awayshots => _awayshots;
  RxString get homeshotsongoal => _homeshotsongoal;
  RxString get awayshotsongoal => _awayshotsongoal;
  RxString get homeFouls => _homeFouls;
  RxString get awayFouls => _awayFouls;
  RxString get homecorners => _homecorners;
  RxString get awaycorners => _awaycorners;
  RxString get homesaves => _homesaves;
  RxString get awaysaves => _awaysaves;

  @override
  initialize() {}

  void setresult(Fixtures? value) {
    fixtures = value;
    ballPossession(value);
  }

  void ballPossession(Fixtures? fixturesx) {
    RxString homeposession = "0".obs;
    RxString awayposession = "0".obs;
    if (fixturesx?.statistics != null) {
      for (var fix in fixturesx!.statistics!) {
        if (fix.type == "Ball Possession") {
          homeposession.value = fix.home!;
          awayposession.value = fix.away!;
        }
        if (fix.type == "Yellow Cards") {
          _homecards.value = fix.home!;
          _awaycards.value = fix.away!;
        }
        if (fix.type == "Shots Total") {
          _homecshots.value = fix.home!;
          _awayshots.value = fix.away!;
        }
        if (fix.type == "Shots On Goal") {
          _homeshotsongoal.value = fix.home!;
          _awayshotsongoal.value = fix.away!;
        }
        if (fix.type == "Fouls") {
          _homeFouls.value = fix.home!;
          _awayFouls.value = fix.away!;
        }
        if (fix.type == "Red Cards") {
          _homecardsred.value = fix.home!;
          _awaycardsred.value = fix.away!;
        }
        if (fix.type == "Corners") {
          _homecorners.value = fix.home!;
          _awaycorners.value = fix.away!;
        }
        if (fix.type == "Saves") {
          _homesaves.value = fix.home!;
          _awaysaves.value = fix.away!;
        }
      }
    }
    _homepossession.value = homeposession.value.replaceAll('%', '');
    _awaypossession.value = awayposession.value.replaceAll('%', '');
  }
}

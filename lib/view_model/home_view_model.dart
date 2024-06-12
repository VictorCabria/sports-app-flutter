import 'package:deporte_app_flutter/model/clasificacion.dart';
import 'package:deporte_app_flutter/model/league.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../model/country.dart';
import '../model/menu_item.dart';
import '../services/clasificacion_services.dart';
import '../services/ligas_services.dart';
import '../services/paises_services.dart';
import 'root_view_model.dart';
import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewHomeViewModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewHomeViewModel(
    this._navigatorService,
    this._localService,

    /* this._appsflyerSdk, */
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  final RxInt _currentIndex = 0.obs;
  final RxList<Country> _countries = <Country>[].obs;
  final RxList<League> _leagues = <League>[].obs;
  final RxList<Standing> _standing = <Standing>[].obs;

  //getters

  int get currentIndex => _currentIndex.value;
  List<Country> get countries => _countries;
  List<League> get leagues => _leagues;
  List<Standing> get standing => _standing;

  //setters
  set currentIndex(int value) => _currentIndex.value = value;

  @override
  initialize() async {
    /*  await getcountry(); */
    await getleague();
  }

  getleague() async {
    var result = await leagueServices.fetchleague();
    _leagues.addAll(result);

 /*    for (int i = 0; i < result.length; i++) {
      var league = result[i];
      await getstating(league.leagueKey!);
    } */
  }
/* 
  getstating(int leagueKey) async {
    var result = await clasificacionServices.fetchStanding(leagueKey);
    _standing.add(result.result as Standing);
  } */

  void onMenuChanged(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
    }
  }
}

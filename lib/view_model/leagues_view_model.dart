
import 'package:deporte_app_flutter/model/configs/league.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../model/configs/country.dart';
import '../services/ligas_services.dart';
import '../services/paises_services.dart';
import 'root_view_model.dart';
import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewLeaguesWidgetViewModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewLeaguesWidgetViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  final RxList<Country> _countries = <Country>[].obs;
  final RxList<League> _leagues = <League>[].obs;

  // Getters
  List<Country> get countries => _countries;
  List<League> get leagues => _leagues;

  @override
  initialize() async {
    await getleague();
  }

  getleague() async {
    var result = await leagueServices.fetchLeague();
    _leagues.addAll(result);
  }
}

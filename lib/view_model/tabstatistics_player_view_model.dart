import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/player_soccer.dart';
import '../model/configs/standing.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/player_soccer_services.dart';
import '../services/standing_services.dart';

class TabStatisticsPlayerViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabStatisticsPlayerViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Player? fixtures;
  final RxList<PlayerSoccer> _playerSoccer = <PlayerSoccer>[].obs;

  // Getters
  List<PlayerSoccer> get playerSoccer => _playerSoccer;

  @override
  initialize() {

    
  }
  void setresult(Player? value) {
    fixtures = value;
    getresult(value!);
  }

  void getresult(Player player) async {
    var result = await playSoccerServices
        .fetchplaySoccerlist(player.playerKey.toString());

    _playerSoccer.addAll(result);
  }
}

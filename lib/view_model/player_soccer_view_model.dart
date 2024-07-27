import 'package:deporte_app_flutter/model/configs/fixtures.dart';
import 'package:deporte_app_flutter/services/player_soccer_services.dart';
import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:palette_generator/palette_generator.dart';

import '../domain/local_service.dart';
import '../model/configs/player_soccer.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class PlayerSoccerViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  PlayerSoccerViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  final RxList<PlayerSoccer> _playerSoccer = <PlayerSoccer>[].obs;
  final RxString _playsoccer = ''.obs;
  Player? player;
  Fixtures? fixtures;
  final RxInt _edad = 0.obs;
  final RxInt _playernumber = 0.obs;
  final RxInt _yearActual = DateTime.now().year.obs;
  final RxInt _yearnacimiento = 0.obs;
  final RxString _urlplayer = "".obs;
  final RxString _urlteams = "".obs;
  final RxString _playercountry = "".obs;
  final RxString _playertype = "".obs;
  final RxString _playergoals = "".obs;
  final RxString _playerassists = "".obs;
  final RxString _playermatchplayed = "".obs;
  final RxString _playersubstitutes = "".obs;
  final RxString _playerrating = "".obs;
  final RxString _playerteam = "".obs;
  final RxString _homeresult = ''.obs;
  final RxString _awayresult = ''.obs;
  final Rx<Color?> _dominantColor = Rx<Color?>(null);

  /* int anoNacimiento = anoActual - edad; */

  // Getters
  List<PlayerSoccer> get playerSoccer => _playerSoccer;
  RxString get playsoccer => _playsoccer;
  RxString get urlplayer => _urlplayer;
  RxString get urlteams => _urlteams;
  RxString get playercountry => _playercountry;
  RxString get playertype => _playertype;
  RxInt get edad => _edad;
  RxString get playerteam => _playerteam;
  RxString get playergoals => _playergoals;
  RxString get playerassists => _playerassists;
  RxString get playermatchplayed => _playermatchplayed;
  RxString get playersubstitutes => _playersubstitutes;
  RxString get playerrating => _playerrating;
  RxInt get yearActual => _yearActual;
  RxInt get yearnacimiento => _yearnacimiento;
  RxInt get playernumber => _playernumber;
  RxString get homeresult => _homeresult;
  RxString get awayresult => _awayresult;
  Rx<Color?> get dominantColor => _dominantColor;

  @override
  initialize() async {
    player = Get.arguments['player'];
    fixtures = Get.arguments['fixtures'];
    getresult(player!);
  }

  void getresult(Player player) async {
    var result = await playSoccerServices.fetchplaySoccer(
        player.playerKey.toString(), fixtures!.leagueKey.toString());

    _playerSoccer.addAll(result);
    for (var res in result) {
      _playsoccer.value = res.playerImage.toString();
      yearcalculate(res);
      urlteam(fixtures, res);
    }
  }

  void urlteam(Fixtures? fixtures, PlayerSoccer? player) {
    if (fixtures != null) {
      if (player?.teamKey == fixtures.homeTeamKey &&
          fixtures.homeTeamLogo!.isNotEmpty) {
        _urlteams.value = fixtures.homeTeamLogo!;
      } else if (player!.teamKey == fixtures.awayTeamKey &&
          fixtures.awayTeamLogo!.isNotEmpty) {
        _urlteams.value = fixtures.awayTeamLogo!;
      } else {
        _urlteams.value = '';
      }
    }
  }

  getback() {
    _navigatorService.toBack();
  }

  void yearcalculate(PlayerSoccer player) {
    var data = "";
    if (player.playerAge != "") {
      _edad.value = int.parse(player.playerAge);
      _yearnacimiento.value = _yearActual.value - edad.value;
    }
    if (player.playerNumber != "") {
      _playernumber.value = int.parse(player.playerNumber);
    }
    _urlplayer.value = player.playerImage.toString();
    _playercountry.value = player.playerCountry.toString();
    _playertype.value = player.playerType.toString();
    _playergoals.value = player.playerGoals.toString();
    _playerassists.value = player.playerAssists.toString();
    _playermatchplayed.value = player.playerMatchPlayed.toString();
    _playersubstitutes.value = player.playerSubstitutesOnBench.toString();
    _playerrating.value = player.playerRating.toString();
    if (player.teamName != "") {
      data = player.teamName.toString();
      _playerteam.value = player.teamName.toString();
    }

    List<String> parts = data.split(' ');

    if (parts.length == 1) {
      _homeresult.value = parts[0];
      _awayresult.value = parts[0];
    } else if (parts.length >= 2) {
      _homeresult.value = parts[0];
      _awayresult.value = parts[1];
    } else {
      _homeresult.value = data;
      _awayresult.value = data;
    }
  }
}

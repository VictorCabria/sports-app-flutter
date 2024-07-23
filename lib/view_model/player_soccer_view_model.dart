import 'package:deporte_app_flutter/model/configs/fixtures.dart';
import 'package:deporte_app_flutter/services/player_soccer_services.dart';
import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

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
  final RxString _playerteam = "".obs;
  final RxString _homeresult = ''.obs;
  final RxString _awayresult = ''.obs;
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
  RxInt get yearActual => _yearActual;
  RxInt get yearnacimiento => _yearnacimiento;
  RxInt get playernumber => _playernumber;
  RxString get homeresult => _homeresult;
  RxString get awayresult => _awayresult;

  @override
  initialize() async {
    player = Get.arguments['player'];
    fixtures = Get.arguments['fixtures'];
    getresult(player!);
    
  }

  void getresult(Player player) async {
    var result =
        await playSoccerServices.fetchplaySoccer(player.playerKey.toString());
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
        _urlteams.value =
            ''; // O un valor por defecto si no se encuentra el logo
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
if (player.teamName != "") {
  data = player.teamName.toString();
  _playerteam.value = player.teamName.toString();
}

List<String> parts = data.split(' ');

if (parts.length == 1) {
  // Si solo hay una parte, usa la misma para ambos resultados
  _homeresult.value = parts[0];
  _awayresult.value = parts[0];
} else if (parts.length >= 2) {
  // Si hay dos o más partes, usa las dos primeras partes
  _homeresult.value = parts[0];
  _awayresult.value = parts[1];
} else {
  // Maneja cualquier otro caso según sea necesario
  _homeresult.value = data; // o cualquier valor por defecto
  _awayresult.value = data; // o cualquier valor por defecto
}

}
}
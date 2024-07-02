import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class TabLineupsViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabLineupsViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;
  RxString homeFormation = '4-3-3'.obs;
  RxString awayFormation = '4-1-4-1'.obs;

  @override
  initialize() {
    // TODO: implement initialize
  }

  void setresult(Fixtures? value) {
    fixtures = value;
  }

  void setFormations(String home, String away) {
    homeFormation.value = home;
    awayFormation.value = away;
  }

  Widget buildFormation(String formation, List<Player> players) {
    List<String> positions = formation.split('-');
    List<Widget> rowsWidgets = [];
    double containerHeight = 190.0.dp; 
    double containerWidth = 100.0.dp;

    double rowSpacing = containerHeight / (positions.length + 1);

    // Ordenar los jugadores por su posición y excluir al portero
    players.sort((a, b) => b.playerPosition!.compareTo(a.playerPosition!));
    List<Player> fieldPlayers =
        players.where((player) => player.playerPosition! != 1).toList();

    // Asegurar que siempre haya suficientes jugadores para completar la formación
    while (fieldPlayers.length < 10) {
      fieldPlayers.add(Player(
        player: 'N/A',
        playerNumber: 0,
        playerPosition: 0,
      ));
    }

    // Extraer las posiciones en orden
    List<int> playerNumbers =
        fieldPlayers.map((player) => player.playerPosition!).toList();

    int playerIndex = 0;

    for (int i = positions.length - 1; i >= 0; i--) {
      int numPlayers = int.parse(positions[i]);
      double colSpacing = containerWidth / (numPlayers + 1);

      List<Widget> rowPlayers = [];

      for (int j = 0; j < numPlayers; j++) {
        // Asegurarse de que no intentamos acceder a un índice fuera de los límites de la lista
        if (playerIndex < fieldPlayers.length) {
          // Obtener el número de jugador desde la lista de números predefinidos
          int positionNumber = playerNumbers[playerIndex];
          playerIndex++;

          // Encontrar el jugador correspondiente
          Player currentPlayer = fieldPlayers[playerIndex - 1];

          rowPlayers.add(
            Column(
              children: [
                Container(
                  width: 40.0.sp,
                  height: 20.0.sp,
                  margin: EdgeInsets.symmetric(horizontal: colSpacing / 3),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      currentPlayer.playerNumber != 0
                          ? currentPlayer.playerNumber.toString()
                          : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0.sp),
                Text(
                  currentPlayer.player ?? "", // Mostrar el nombre del jugador
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0.sp,
                  ),
                ),
              ],
            ),
          );
        }
      }

      rowsWidgets.add(
        Container(
          height: rowSpacing,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowPlayers,
          ),
        ),
      );
    }

    // Encontrar y mostrar al portero en la posición correspondiente
    Player? goalkeeper = players.firstWhere(
        (player) => player.playerPosition == 1,
        orElse: () =>
            Player(player: 'Portero', playerNumber: 1, playerPosition: 1));

    // Agregar el portero en la parte inferior
    rowsWidgets.add(
      Container(
        height: rowSpacing,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        10.0.sp), // Ajusta el margen según sea necesario
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20.0.sp, // Reducir el tamaño del círculo azul
                      height: 20.0.sp, // Reducir el tamaño del círculo azul
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          goalkeeper.playerNumber != 0
                              ? goalkeeper.playerNumber.toString()
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0
                                .sp, // Reducir el tamaño de la fuente del número
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 2.0.sp), // Espacio entre el número y el nombre
                    Text(
                      goalkeeper.player ?? "", // Mostrar el nombre del portero
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            8.0.sp, // Reducir el tamaño de la fuente del nombre
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      verticalDirection: VerticalDirection.down,
      children: rowsWidgets,
    );
  }
}

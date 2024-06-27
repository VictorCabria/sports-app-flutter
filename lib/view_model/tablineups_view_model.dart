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

  Widget buildFormation(String formation) {
    List<String> positions = formation.split('-');
    List<Widget> rowsWidgets = [];
    double containerHeight = 150.dp;
    double containerWidth = 250.dp;

    double rowSpacing = containerHeight / (positions.length + 1);

    for (int i = positions.length - 1; i >= 0; i--) {
      int numPlayers = int.parse(positions[i]);
      double colSpacing = containerWidth / (numPlayers + 1);

      List<Widget> rowPlayers = [];

      for (int j = 0; j < numPlayers; j++) {
        rowPlayers.add(
          Container(
            width: 10.dp,
            height: 10.dp,
            margin: EdgeInsets.symmetric(horizontal: colSpacing / 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        );
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      verticalDirection:
          VerticalDirection.up, // Construye de abajo hacia arriba
      children: rowsWidgets,
    );
  }
}

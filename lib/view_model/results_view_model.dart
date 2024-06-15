import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class ResultsModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  ResultsModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

   var matches = <Map<String, String>>[
    {'team1': 'Equipo A', 'team2': 'Equipo D', 'result': '5 - 3'},
    {'team1': 'Equipo B', 'team2': 'Equipo E', 'result': '2 - 2'},
    {'team1': 'Equipo C', 'team2': 'Equipo F', 'result': '4 - 1'},
    {'team1': 'Equipo A', 'team2': 'Equipo E', 'result': '3 - 2'},
    {'team1': 'Equipo B', 'team2': 'Equipo F', 'result': '1 - 4'},
    {'team1': 'Equipo C', 'team2': 'Equipo D', 'result': '3 - 3'},
    {'team1': 'Equipo A', 'team2': 'Equipo F', 'result': '2 - 2'},
    {'team1': 'Equipo B', 'team2': 'Equipo D', 'result': '5 - 3'},
    {'team1': 'Equipo C', 'team2': 'Equipo E', 'result': '4 - 0'},
  ].obs;

  @override
  initialize() {}
}

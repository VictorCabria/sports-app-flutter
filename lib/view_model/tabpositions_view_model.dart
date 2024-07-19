import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/standing.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/standing_services.dart';

class TabPositionsViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabPositionsViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;
  final RxList<Standing> _standing = <Standing>[].obs;

  final RxString _errorMessage = ''.obs;
  RxList<Map<String, dynamic>> categorizedtabpositions =
      <Map<String, dynamic>>[].obs;

  // Getters
  List<Standing> get standing => _standing;
  @override
  initialize() {}
  void setresult(Fixtures? value) {
    fixtures = value;
    getresult21(fixtures);
  }

  void getresult(Fixtures? value) async {
    try {
      var response = await standingServices
          .fetchstandingsleague(value!.leagueKey.toString());
      for (var standing in response.total!) {
        _standing.add(standing);
      }
    } catch (e) {
      print('Error al obtener los datos de la API: $e');
    }
  }

  void getresult21(Fixtures? value) async {
    try {
      var response = await standingServices
          .fetchstandingsleague(value!.leagueKey.toString());
      Map<String, List<Standing>> groupedResults = {};

      if (response.total != null && response.total!.isNotEmpty) {
        // Verifica si hay algún leagueRound en los resultados
        bool hasLeagueRound = response.total!.any((result) =>
            result.leagueRound != null && result.leagueRound!.isNotEmpty);

        if (hasLeagueRound) {
          // Agrupa los resultados por leagueRound si existe
          for (var result in response.total!) {
            if (result.leagueRound != null && result.leagueRound!.isNotEmpty) {
              if (!groupedResults.containsKey(result.leagueRound!)) {
                groupedResults[result.leagueRound!] = [];
              }
              groupedResults[result.leagueRound!]!.add(result);
            }
          }
          categorizedtabpositions.value = groupedResults.entries.map((entry) {
            return {
              'leagueRound': entry.key,
              'results': entry.value,
            };
          }).toList();
        } else {
          // Si no hay leagueRound, trae la lista completa sin agrupar
          categorizedtabpositions.value = [
            {
              'leagueRound': 'Todos',
              'results': response.total!,
            }
          ];
        }
      } else {
        // Maneja el caso en que response.total sea nulo o vacío
        categorizedtabpositions.value = [];
      }
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }
}

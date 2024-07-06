import 'dart:async';

import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/fixtures_services.dart';

class TabResultViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabResultViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;

  final RxList<Fixtures> _liveresult = <Fixtures>[].obs;
  final RxString _errorMessage = ''.obs;
  Timer? _timer;
  RxList<Map<String, dynamic>> categorizedResults =
      <Map<String, dynamic>>[].obs;

  // Getters
  List<Fixtures> get liveresult => _liveresult;
  @override
  initialize() {}

  void setresult(Fixtures? value) {
    fixtures = value;
    getresult(value);
  }

  void getresult(Fixtures? value) async {
    try {
      var results = await fixturesServices
          .fetchresultliveleague(value!.leagueKey.toString());
      Map<String, List<Fixtures>> groupedResults = {};
      for (var result in results) {
        if (!groupedResults.containsKey(result.eventDate!)) {
          groupedResults[result.eventDate!] = [];
        }
        groupedResults[result.eventDate!]!.add(result);
      }
      categorizedResults.value = groupedResults.entries.map((entry) {
        return {
          'eventdate': entry.key,
          'results': entry.value,
        };
      }).toList();
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }

  String formatDateString(String? dateString) {
    if (dateString == null) return "Pendiente";

    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('EEEE, MMMM d', 'es_ES');
      return formatter.format(date);
    } catch (e) {
      return "Pendiente";
    }
  }

  void inforesult(Fixtures resultlive) {
    _navigatorService.toInfoResult(resultlive);
  }
}

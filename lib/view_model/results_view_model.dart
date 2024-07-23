import 'dart:async';

import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/fixtures_services.dart';

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

  final RxList<Fixtures> _liveresult = <Fixtures>[].obs;
  final RxString _errorMessage = ''.obs;
  Timer? _timer;
  final RxBool _isBuscar = false.obs;
  RxList<Map<String, dynamic>> categorizedResults =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> categorizedResultsfilter =
      <Map<String, dynamic>>[].obs;

  // Getters
  List<Fixtures> get liveresult => _liveresult;
  RxString get errorMessage => _errorMessage;
  RxBool get isBuscar => _isBuscar;

  @override
  initialize() async {
    _startLiveUpdates();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startLiveUpdates() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      getresult();
    });
    getresult(); // Obtener resultados de inmediato al iniciar
  }

  getresult() async {
    try {
      var results = await fixturesServices.fetchresultlive();
      Map<String, List<Fixtures>> groupedResults = {};
      for (var result in results) {
        if (!groupedResults.containsKey(result.leagueName!)) {
          groupedResults[result.leagueName!] = [];
        }
        groupedResults[result.leagueName!]!.add(result);
      }

      categorizedResults.value = groupedResults.entries.map((entry) {
        return {
          'leagueName': entry.key,
          'results': entry.value,
        };
      }).toList();

      // Copy the categorizedResults to categorizedResultsfilter for filtering
      categorizedResultsfilter.value =
          List<Map<String, dynamic>>.from(categorizedResults);
      // Reapply the filter after updating the results
      filterList(currentQuery);
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }

  void inforesult(Fixtures resultlive) {
    _localService.setUserToEdit(resultlive);
    _navigatorService.toInfoResult(resultlive);
    if (isBuscar.value) {
      buscar();
    }
  }

  void infoleague(Fixtures resultlive) {
    _navigatorService.toInfoleague(resultlive);
  }

  void buscar() {
    isBuscar.value = !isBuscar.value;
    if (!isBuscar.value) {
      filterList(''); // Reset to original list when search is closed
    }
  }

  String currentQuery = ''; // Store the current query

  void filterList(String query) {
    currentQuery = query; // Update the current query
    if (query.isNotEmpty) {
      String lowercaseQuery = query.toLowerCase();
      categorizedResults.value = categorizedResultsfilter.where((element) {
        return (element['leagueName']?.toLowerCase() ?? '')
            .contains(lowercaseQuery);
      }).toList();
    } else {
      categorizedResults.value =
          List<Map<String, dynamic>>.from(categorizedResultsfilter);
    }
  }

  String getPenaltyWinner(Fixtures result) {
    if (result.eventStatus == "After Pen." &&
        result.eventPenaltyResult != null) {
      List<String> scores = result.eventPenaltyResult!.split(" - ");
      if (scores.length == 2) {
        int homeScore = int.parse(scores[0]);
        int awayScore = int.parse(scores[1]);
        if (homeScore > awayScore) {
          return result.eventHomeTeam ?? "";
        } else if (awayScore > homeScore) {
          return result.eventAwayTeam ?? "";
        }
      }
    }
    return "";
  }
}

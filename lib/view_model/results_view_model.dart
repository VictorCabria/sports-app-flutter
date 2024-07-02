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
  RxList<Map<String, dynamic>> categorizedResults =
      <Map<String, dynamic>>[].obs;

  // Getters
  List<Fixtures> get liveresult => _liveresult;
  RxString get errorMessage => _errorMessage;

  @override
  initialize() async {
    _startLiveUpdates();
  }

  @override
  void onClose() {
    _timer
        ?.cancel(); // Cancelar el temporizador cuando el controlador se cierre
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
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }

  void inforesult(Fixtures resultlive) {
    _navigatorService.toInfoResult(resultlive);
  }
}

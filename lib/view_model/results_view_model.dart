import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/live_result.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/result_live_services.dart';

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

  final RxList<Resultlive> _liveresult = <Resultlive>[].obs;
  RxList<Map<String, dynamic>> categorizedResults =
      <Map<String, dynamic>>[].obs;
  // Getters
  List<Resultlive> get liveresult => _liveresult;

  @override
  initialize() async {
    await getresult();
  }

  getresult() async {
    var results = await resultliveServices.fetchresultlive();
    Map<String, List<Resultlive>> groupedResults = {};
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
  }
}

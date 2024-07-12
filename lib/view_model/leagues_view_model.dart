import 'dart:async';

import 'package:deporte_app_flutter/model/configs/league.dart';
import 'package:deporte_app_flutter/services/commet_services.dart';
import 'package:get/get.dart';
import '../model/configs/comment.dart';
import '../model/configs/country.dart';
import '../model/configs/livescore.dart';
import '../services/ligas_services.dart';
import '../services/livescore_services.dart';
import '../services/paises_services.dart';
import 'root_view_model.dart';
import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewLeaguesWidgetViewModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewLeaguesWidgetViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  final RxString _homeresult = ''.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _awayresult = ''.obs;
   var latestComments = <String, Comment>{}.obs; 
  Timer? _timer;
  final RxList<Country> _countries = <Country>[].obs;
  final RxList<LivesScore> _leagues = <LivesScore>[].obs;
  RxList<Map<String, dynamic>> categorizedResults =
      <Map<String, dynamic>>[].obs;

  // Getters
  List<Country> get countries => _countries;
  List<LivesScore> get leagues => _leagues;
  RxString get homeresult => _homeresult;
  RxString get awayresult => _awayresult;

  @override
  void initialize() {
    _startLiveUpdates();
  }

  void _startLiveUpdates() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      getresult();
    });
    getresult(); // Fetch initial data
  }

/*   Future<void> getLeague() async {
    var result = await liverScoreServices.fetchLeague();
    updateLeagueList(result);
  }
 */
  void getresult() async {
    try {
      var results = await liverScoreServices.fetchLeague();
      Map<String, List<LivesScore>> groupedResults = {};
      for (var result in results) {
        if (!groupedResults.containsKey(result.eventKey.toString())) {
          groupedResults[result.eventKey.toString()] = [];
        }
        groupedResults[result.eventKey.toString()]!.add(result);
      }
      categorizedResults.value = groupedResults.entries.map((entry) {
        return {
          'eventkey': entry.key,
          'results': entry.value,
        };
      }).toList();
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }


  Future<void> getresultcomment(String idman) async {
    try {
      var results = await commentsServices.fetchcomment(idman);
      if (results != null && results.isNotEmpty) {
        latestComments[idman] = results.last; // Almacenar solo el último comentario
      }
    } catch (e) {
      _errorMessage.value = 'Error al obtener los resultados: $e';
    }
  }


  void formatLeagueResults(LivesScore league) {
    var data = "";
    if (league.eventStatus != "") {
      if (league.eventStatus == "After Pen.") {
        data = league.eventFtResult.toString();
      } else if (league.eventStatus == "After ET") {
        data = league.eventFinalResult.toString();
      } else if (league.eventFtResult != "") {
        data = league.eventFtResult.toString();
      } else {
        data = league.eventFinalResult.toString();
      }
      List<String> parts = data.split('-');

      _homeresult.value = parts[0];
      _awayresult.value = parts[1];
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

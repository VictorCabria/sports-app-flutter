import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewInforesultModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewInforesultModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? resultlive;
  final RxString _homeresult = ''.obs;
  final RxString _awayresult = ''.obs;
  final RxList<GoalScorer> _homeGoals = <GoalScorer>[].obs;
  final RxList<GoalScorer> _awayGoals = <GoalScorer>[].obs;

  //getters
  RxString get homeresult => _homeresult;
  RxString get awayresult => _awayresult;
  RxList<GoalScorer> get homeGoals => _homeGoals;
  RxList<GoalScorer> get awayGoals => _awayGoals;

  @override
  initialize() async {
    resultlive = Get.arguments;
    print(resultlive);
    formatData(resultlive!.eventFinalResult!);
    separateGoals();
  }

  void separateGoals() {
    if (resultlive?.goalscorers != null) {
      for (var goal in resultlive!.goalscorers!) {
        if (goal.homeScorer != "") {
          _homeGoals.add(goal);
        }
        if (goal.awayScorer != "") {
          _awayGoals.add(goal);
        }
      }
    }
  }

  formatData(String data) {
    List<String> parts = data.split('-');

    _homeresult.value = parts[0];
    _awayresult.value = parts[1];
  }

  getback() {
    _navigatorService.toBack();
  }
}

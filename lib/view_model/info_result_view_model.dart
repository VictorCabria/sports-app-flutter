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
  Fixtures? fixtures;
  final RxString _homeresult = ''.obs;
  final RxString _awayresult = ''.obs;
  final RxBool _penaltys = false.obs;
  final RxList<GoalScorer> _homeGoals = <GoalScorer>[].obs;
  final RxList<GoalScorer> _awayGoals = <GoalScorer>[].obs;
  final RxList<GoalScorer> _homepenalesGoals = <GoalScorer>[].obs;
  final RxList<GoalScorer> _awaypenalesGoals = <GoalScorer>[].obs;
  String homeFormation = "4-3-3";
  String awayFormation = "4-1-4-1";

  //getters
  RxString get homeresult => _homeresult;
  RxString get awayresult => _awayresult;
  RxBool get penaltys => _penaltys;
  RxList<GoalScorer> get homeGoals => _homeGoals;
  RxList<GoalScorer> get awayGoals => _awayGoals;
  RxList<GoalScorer> get homepenalesGoals => _homepenalesGoals;
  RxList<GoalScorer> get awaypenalesGoals => _awaypenalesGoals;

  @override
  initialize() async {
    fixtures = Get.arguments;
    print(fixtures);
    formatData(fixtures);
    separateGoals();
    separateGoalsPenales();
  }

  void separateGoals() {
    if (fixtures?.goalscorers != null) {
      for (var goal in fixtures!.goalscorers!) {
        if (goal.infoTime == "Penalty") {
        } else {
          if (goal.homeScorer != "") {
            homeGoals.add(goal);
          }
          if (goal.awayScorer != "") {
            awayGoals.add(goal);
          }
        }
      }
    }
  }

  void separateGoalsPenales() {
    if (fixtures?.goalscorers != null) {
      for (var goal in fixtures!.goalscorers!) {
        if (goal.infoTime == "Penalty") {
          penaltys.value = true;
          if (goal.homeScorer != "") {
            _homepenalesGoals.add(goal);
          }
          if (goal.awayScorer != "") {
            _awaypenalesGoals.add(goal);
          }
        }
      }
    }
  }

  List<List<String>> getFormation(String formationString) {
    List<String> parts = formationString.split('-');
    List<int> formation = parts.map((part) => int.parse(part)).toList();

    List<List<String>> players = [];

    for (int i = 0; i < formation.length; i++) {
      List<String> line = [];
      for (int j = 0; j < formation[i]; j++) {
        line.add('Player');
      }
      players.add(line);
    }

    return players;
  }

  formatData(Fixtures? fixtures) {
    var data = "";
    if (fixtures!.eventStatus != "") {
      if (fixtures.eventStatus == "After Pen.") {
        data = fixtures.eventFtResult.toString();
      } else if (fixtures.eventStatus == "After ET") {
        data = fixtures.eventFinalResult.toString();
      } else if (fixtures.eventFtResult != "") {
        data = fixtures.eventFtResult.toString();
      } else {
        data = fixtures.eventFinalResult.toString();
      }
      List<String> parts = data.split('-');

      _homeresult.value = parts[0];
      _awayresult.value = parts[1];
    }
  }

  getback() {
    _navigatorService.toBack();
  }

  void closeApp() {
    _navigatorService.closeApp();
  }
}

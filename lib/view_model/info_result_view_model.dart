import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import '../domain/local_service.dart';
import '../model/configs/live_result.dart';
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
  var selectedIndex = 0.obs;
  Resultlive? resultlive;
  @override
  initialize() async {
    resultlive = Get.arguments;
    print(resultlive);
  }

  getback() {
    _navigatorService.toBack();
  }
}

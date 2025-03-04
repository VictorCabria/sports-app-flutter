import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewHomeViewModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewHomeViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  var selectedIndex = 0.obs;
  @override
  initialize() async {}

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

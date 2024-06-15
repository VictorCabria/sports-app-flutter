import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

import '../services/ligas_services.dart';

class LoginWidgetModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  LoginWidgetModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  final TextEditingController _codeController = TextEditingController();
  RxString _apiKey = ''.obs;

  //getters
  TextEditingController get codeController => _codeController;
  RxString get apiKey => _apiKey;

  @override
  initialize() {}

  void setApiKey(String apiKey) {
    if (_validateApiKey(apiKey)) {
      _apiKey.value = apiKey;
      leagueServices.updateApiKey(apiKey);
      _navigatorService.remplaceAllToHome();
    } else {
      print("API key no es válida");
    }
  }

  bool _validateApiKey(String apiKey) {
    if (apiKey.isEmpty) {
      return false;
    }
    if (apiKey.length < 64) {
      return false;
    }

    return true;
  }
}

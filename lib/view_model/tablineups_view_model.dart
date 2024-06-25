import 'package:deporte_app_flutter/view_model/root_view_model.dart';

import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class TabLineupsViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabLineupsViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  @override
  initialize() {
    // TODO: implement initialize
  }
}

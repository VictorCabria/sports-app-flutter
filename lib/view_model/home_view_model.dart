import 'package:get/get.dart';
import 'root_view_model.dart';
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

    /* this._appsflyerSdk, */
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  @override
  initialize() async {}
}

import 'package:get/get.dart';
import '../model/menu_item.dart';
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
  final RxInt _currentIndex = 0.obs;

  //getters

  int get currentIndex => _currentIndex.value;

  //setters
  set currentIndex(int value) => _currentIndex.value = value;

  @override
  initialize() async {}

  void onMenuChanged(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
    }
  }
}

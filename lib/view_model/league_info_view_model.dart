import 'package:get/get.dart';
import '../model/configs/fixtures.dart';
import '../services/fixtures_services.dart';
import 'root_view_model.dart';
import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';

class NewLeaguesInfoWidgetViewModel extends RootViewModel
    with GetSingleTickerProviderStateMixin {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  NewLeaguesInfoWidgetViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;

  final RxList<Fixtures> _liveresult = <Fixtures>[].obs;

  // Getters
  List<Fixtures> get liveresult => _liveresult;
  @override
  initialize() async {
    fixtures = Get.arguments;
    print(fixtures);
  }

 

  getback() {
    _navigatorService.toBack();
  }
}

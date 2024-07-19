import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/fixtures.dart';
import '../model/configs/topscorers.dart';
import '../model/h2hmatch_page.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/h2h_services.dart';

class TabHeadToHeadViewModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  TabHeadToHeadViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
  Fixtures? fixtures;
   final RxList<H2HDetails> _h2hdetails = <H2HDetails>[].obs;

  //getters
  List<H2HDetails> get h2hdetails => _h2hdetails;
  @override
  initialize() {
    // TODO: implement initialize
  }
  void setresult(Fixtures? value) {
    fixtures = value;
    getresult(value);
  }

  void getresult(Fixtures? value) async {
    var results = await h2hServices.fetchh2h(
      value!.homeTeamKey.toString(),
      value.awayTeamKey.toString(),
    );
     _h2hdetails.add(results);
  }

   void inforesult(Fixtures resultlive) {
    _localService.setUserToEdit(resultlive);
    _navigatorService.toInfoResult(resultlive);
  }

}

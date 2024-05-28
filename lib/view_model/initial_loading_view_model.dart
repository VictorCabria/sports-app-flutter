import 'package:get/get.dart';

import '../routes/routes_navigator_service.dart';
import 'root_view_model.dart';

class InitialLoadingViewModel extends RootViewModel {
  RoutesNavigatorService _navigatorService;

  InitialLoadingViewModel(
    this._navigatorService,
  ) : super(null) {
    initialize();
  }

  @override
  initialize() {
    Future.delayed(Duration(milliseconds: 100), () {
      Get.offNamed(
        _navigatorService.initialRoute,
        arguments: _navigatorService.initialArguments,
      );
    });
  }
}

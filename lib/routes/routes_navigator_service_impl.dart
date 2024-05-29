import 'package:deporte_app_flutter/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/history_page.dart';
import '../widget/initial_loading.dart';
import '../widget/splash_screen_widget.dart';
import 'routes_navigator_service.dart';

class RoutesNavigatorServiceImpl extends RoutesNavigatorService {
  final LocalService _localService;
  List<HistoryPage> _navigatorHistory = [];
  RoutesNavigatorServiceImpl(this._localService) {
    init();
  }

  Future<void> init() async {
    _navigatorHistory = await _localService.getNavigatorHistory() ?? [];

    _initialRoute = _navigatorHistory.isNotEmpty
        ? _navigatorHistory.last.route
        : _splashScreen;

    /* switch (_initialRoute) {
      case _iframe:
        _navigatorHistory.removeLast();
        _initialRoute = _navigatorHistory.isNotEmpty
            ? _navigatorHistory.last.route
            : _splashScreen;
        break;
      case _faqResponse:
        _navigatorHistory.removeLast();
        _initialRoute = _navigatorHistory.isNotEmpty
            ? _navigatorHistory.last.route
            : _splashScreen;
        break;
    } */
    _initialArguments =
        _navigatorHistory.isNotEmpty ? _navigatorHistory.last.arguments : null;

    routes = [
      GetPage(
        name: _intialLoading,
        page: () => InitialLoadingWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _splashScreen,
        page: () => SplashScreenWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _home,
        page: () => HomeWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
    ];
  }

  @override
  String get initialRoute => _initialRoute;
  Map<String, dynamic>? get initialArguments => _initialArguments;

  String _initialRoute = _splashScreen;
  Map<String, dynamic>? _initialArguments;

  static const _intialLoading = '/';
  static const _splashScreen = '/splashScreen';
  static const _home = '/home';

  List<GetPage> routes = [];

  get getRoutes => routes;
  get getInitialRoute => _initialRoute;
  String get getInitialLoading => _intialLoading;
  Map<String, dynamic>? get arguments =>
      _navigatorHistory.isNotEmpty ? _navigatorHistory.last.arguments : null;

  String get routeName =>
      _navigatorHistory.isNotEmpty ? _navigatorHistory.last.route : '/';

  bool get isEmpty => _navigatorHistory.isEmpty;

  void onRedirect(String routeName, {Map<String, dynamic>? arguments}) {
    _navigatorHistory.isNotEmpty ? _navigatorHistory.removeLast() : null;
    _navigatorHistory.add(HistoryPage(route: routeName, arguments: arguments));
    _localService.setNavigatorHistory(_navigatorHistory);
  }

  @override
  Future<void> closeApp() async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      SystemNavigator.pop();
      _navigatorHistory.clear();
      _localService.setNavigatorHistory(_navigatorHistory);
    } else {
      remplaceAllToSplash();
    }
  }

  @override
  Future<void> toInitial() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _initialRoute));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_initialRoute);
  }

  @override
  Future<void> remplaceAllToSplash() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _splashScreen));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_splashScreen);
  }

    @override
  Future<void> remplaceAllToHome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _home));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_home);
  }
}

// middlewares

class DataMiddleware extends GetMiddleware {
  RoutesNavigatorService _navigatorService;

  DataMiddleware(this._navigatorService);

  @override
  RouteSettings? redirect(String? route) {
    if (_navigatorService.isEmpty) {
      _navigatorService.onRedirect(_navigatorService.initialRoute);
      return RouteSettings(name: _navigatorService.initialRoute);
    }

    return null;
  }
}

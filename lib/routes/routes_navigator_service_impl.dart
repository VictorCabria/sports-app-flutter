import 'package:deporte_app_flutter/model/configs/fixtures.dart';
import 'package:deporte_app_flutter/widget/home_widget.dart';
import 'package:deporte_app_flutter/widget/leagues_widget.dart';
import 'package:deporte_app_flutter/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../model/configs/fixtures.dart';
import '../domain/local_service.dart';
import '../model/configs/livescore.dart';
import '../model/history_page.dart';
import '../widget/info_resullt_widget.dart';
import '../widget/initial_loading.dart';
import '../widget/leagues_info_widget.dart';
import '../widget/player_soccer_widget.dart';
import '../widget/splash_screen_widget.dart';
import '../widget/user_profile_widget.dart';
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
        ? _navigatorHistory.first.route
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
        _navigatorHistory.isNotEmpty ? _navigatorHistory.first.arguments : null;

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
        name: _leagues,
        page: () => LeaguesWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _leaguesinfo,
        page: () => LeaguesInfoWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _userprofile,
        page: () => UserProfileWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _playersoccer,
        page: () => PlayerSoccerWidget(),
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
      GetPage(
        name: _login,
        page: () => LoginWidget(),
        middlewares: [
          DataMiddleware(
            this,
          ),
        ],
      ),
      GetPage(
        name: _resultinfo,
        page: () => InfoResultWidget(),
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
  static const _leagues = '/leagues';
  static const _home = '/home';
  static const _login = '/Login';
  static const _userprofile = '/userprofile';
  static const _resultinfo = '/resultinfo';
  static const _leaguesinfo = '/leaguesinfo';
  static const _playersoccer = '/playersoccer';

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
  Future<void> toBack() async {
    Get.back();
  }

  @override
  Future<void> remplaceAllToHome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _home));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_home);
  }

  @override
  Future<void> remplaceAllTologin() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _login));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_login);
  }

  @override
  Future<void> toInfoResult(Fixtures fixtures) async {
    _navigatorHistory.add(HistoryPage(route: _resultinfo));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_resultinfo, arguments: fixtures);
  }

  @override
  Future<void> toInfoResultlive(LivesScore livescore) async {
    _navigatorHistory.add(HistoryPage(route: _resultinfo));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_resultinfo, arguments: livescore);
  }

  @override
  Future<void> toPlayerSoccer(Player player, Fixtures fixtures) async {
    _navigatorHistory.add(HistoryPage(route: _playersoccer));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_playersoccer,
        arguments: {"player": player, "fixtures": fixtures});
  }

  @override
  Future<void> toInfoleague(Fixtures fixtures) async {
    _navigatorHistory.add(HistoryPage(route: _leaguesinfo));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_leaguesinfo, arguments: fixtures);
  }
}

final RxList<String> allowedRoutes = [
  RoutesNavigatorServiceImpl._splashScreen,
  RoutesNavigatorServiceImpl._leaguesinfo,
  RoutesNavigatorServiceImpl._resultinfo,
  RoutesNavigatorServiceImpl._home,
  RoutesNavigatorServiceImpl._userprofile,
  RoutesNavigatorServiceImpl._leaguesinfo,
  RoutesNavigatorServiceImpl._leagues,
  // Agrega otras rutas permitidas aquí
].obs;

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

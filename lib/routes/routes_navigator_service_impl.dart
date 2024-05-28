import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/history_page.dart';
import '../widget/initial_loading.dart';
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
    ];
  }

  @override
  String get initialRoute => _initialRoute;
  Map<String, dynamic>? get initialArguments => _initialArguments;

  String _initialRoute = _splashScreen;
  Map<String, dynamic>? _initialArguments;

  static const _intialLoading = '/';
  static const _home = '/home';
  static const _login = '/login';
  static const _newlogin = '/newlogin';
  static const _newhome = '/newhome';
  static const _splashScreen = '/splashScreen';
  static const _register = '/register';
  static const _recoveryPassword = '/recoveryPassword';
  static const _resepassword = '/resetpassword';
  static const _waitingRoom = '/waitingRoom';
  static const _userProfile = '/userProfile';
  static const _newuserProfile = '/newuserProfile';
  static const _privacyPolicy = '/privacyPolicy';
  static const _termsUse = '/termsUse';
  static const _faqWidget = '/faqWidget';
  static const _serviceChannel = '/home';
  static const _faqResponse = '/faqResponse';
  static const _editProfile = '/editProfile';
  static const _neweditProfile = '/neweditProfile';
  static const _welcome = '/welcome';
  static const _welcome_1 = '/welcome1';
  static const _welcome_2 = '/welcome2';
  static const _welcome_3 = '/welcome3';
  static const _maps = '/maps';
  static const _scheduleRoom = '/scheduleRoom';
  static const _shope = '/shope';
  static const _iframe = '/iframe';
  static const _consultationCredits = '/consultationCredits';
  static const _newconsultationCredits = '/newconsultationCredits';
  static const _onBoarding = '/onBoarding';
  static const _chooseCountryLanguage = '/chooseCountryLanguage';
  static const _chooseLanguage = '/chooseLanguage';
  static const _newRegister = '/newRegister';

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
  Future<void> remplaceAllToHome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _home));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_home);
  }

  @override
  Future<void> remplaceAllToSplash() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _splashScreen));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_splashScreen);
  }

  @override
  Future<void> remplaceToHome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _home));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_home);
  }

  @override
  Future<void> remplaceToNewHome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _newhome));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_newhome);
  }

  @override
  Future<void> remplaceToIframe() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _iframe));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_iframe);
  }

  @override
  Future<void> remplaceToInitial() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _splashScreen));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_splashScreen);
  }

  @override
  Future<void> remplaceToLogin() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _login));
    Get.offNamed(_login);
  }

  @override
  Future<void> toNewLogin() async {
    _navigatorHistory.add(HistoryPage(route: _newlogin));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_newlogin);
  }

  @override
  Future<void> remplaceToNewLogin() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _newlogin));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_newlogin);
  }

  @override
  Future<void> remplaceAllToNewLogin() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _newlogin));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_newlogin);
  }

  @override
  Future<void> remplaceToMaps() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _maps));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_maps);
  }

  @override
  Future<void> remplaceToRecoveryPassword() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _recoveryPassword));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_recoveryPassword);
  }

  @override
  Future<void> remplaceToRegister() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _register));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_register);
  }

  @override
  Future<void> remplaceToScheduleRoom() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _scheduleRoom));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_scheduleRoom);
  }

  @override
  Future<void> remplaceToShope() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _shope));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_shope);
  }

  @override
  Future<void> remplaceToWaitingRoom() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _waitingRoom));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_waitingRoom);
  }

  @override
  Future<void> toBack() async {
    Get.back();
  }

  @override
  Future<void> toReturn() async {
    _navigatorHistory.removeLast();
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_navigatorHistory.last.route,
        arguments: _navigatorHistory.last.arguments);
  }

  @override
  Future<void> toConsultationCredits() async {
    _navigatorHistory.add(HistoryPage(route: _consultationCredits));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_consultationCredits);
  }

  @override
  Future<void> toNewConsultationCredits() async {
    _navigatorHistory.add(HistoryPage(route: _newconsultationCredits));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_newconsultationCredits);
  }

  @override
  Future<void> toEditProfile() async {
    _navigatorHistory.add(HistoryPage(route: _editProfile));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_editProfile);
  }

  @override
  Future<void> toNewEditProfile() async {
    _navigatorHistory.add(HistoryPage(route: _neweditProfile));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_neweditProfile);
  }

  @override
  Future<void> toFaq() async {
    _navigatorHistory.add(HistoryPage(route: _faqWidget));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_faqWidget);
  }

  @override
  Future<void> toHome() async {
    _navigatorHistory.add(HistoryPage(route: _home));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_home);
  }

  @override
  Future<void> toInitial() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _initialRoute));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offAllNamed(_initialRoute);
  }

  @override
  Future<void> toLogin() async {
    _navigatorHistory.add(HistoryPage(route: _login));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_login);
  }

  @override
  Future<void> toMaps() async {
    _navigatorHistory.add(HistoryPage(route: _maps));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_maps);
  }

  @override
  Future<void> toOnBoarding() async {
    _navigatorHistory.add(HistoryPage(route: _onBoarding));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_onBoarding);
  }

  @override
  Future<void> toPrivacyPolicy() async {
    _navigatorHistory.add(HistoryPage(route: _privacyPolicy));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_privacyPolicy);
  }

  @override
  Future<void> toRecoveryPassword() async {
    _navigatorHistory.add(HistoryPage(route: _recoveryPassword));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_recoveryPassword);
  }

  @override
  Future<void> toResetPassword() async {
    _navigatorHistory.add(HistoryPage(route: _resepassword));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_resepassword);
  }

  @override
  Future<void> toRegister() async {
    _navigatorHistory.add(HistoryPage(route: _register));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_register);
  }

  @override
  Future<void> toServiceChannel() async {
    _navigatorHistory.add(HistoryPage(route: _serviceChannel));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_serviceChannel);
  }

  @override
  Future<void> toShope() async {
    _navigatorHistory.add(HistoryPage(route: _shope));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_shope);
  }

  @override
  Future<void> toTermsUse() async {
    _navigatorHistory.add(HistoryPage(route: _termsUse));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_termsUse);
  }

  @override
  Future<void> toUserProfile() async {
    _navigatorHistory.add(HistoryPage(route: _newuserProfile));
    Get.toNamed(_newuserProfile);
    _localService.setNavigatorHistory(_navigatorHistory);
  }

  @override
  Future<void> toNewUserProfile() async {
    _navigatorHistory.add(HistoryPage(route: _newuserProfile));
    Get.toNamed(_newuserProfile);
    _localService.setNavigatorHistory(_navigatorHistory);
  }

  @override
  Future<void> toWaitingRoom() async {
    _navigatorHistory.add(HistoryPage(route: _waitingRoom));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_waitingRoom);
  }

  @override
  Future<void> toNewRegister() async {
    _navigatorHistory.add(HistoryPage(route: _newRegister));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.toNamed(_newRegister);
  }

  @override
  Future<void> remplaceWelcome() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _welcome));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_welcome);
  }

  @override
  Future<void> remplaceWelcome1() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _welcome_1));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_welcome_1);
  }

  @override
  Future<void> remplaceWelcome2() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _welcome_2));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_welcome_2);
  }

  @override
  Future<void> remplaceWelcome3() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _welcome_3));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_welcome_3);
  }

  @override
  Future<void> remplaceToOnbording() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _onBoarding));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_onBoarding);
  }

  @override
  Future<void> toChooseCountryLanguage() async {
    _navigatorHistory.add(HistoryPage(route: _onBoarding));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_chooseCountryLanguage);
  }

  @override
  Future<void> remplaceToChooseCountryLanguage() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _chooseCountryLanguage));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_chooseCountryLanguage);
  }

  @override
  Future<void> toChooseLanguage() async {
    _navigatorHistory.add(HistoryPage(route: _onBoarding));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_chooseLanguage);
  }

  @override
  Future<void> remplaceToChooseLanguage() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _chooseLanguage));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_chooseLanguage);
  }

  @override
  Future<void> remplaceToNewRegister() async {
    _navigatorHistory.clear();
    _navigatorHistory.add(HistoryPage(route: _newRegister));
    _localService.setNavigatorHistory(_navigatorHistory);
    Get.offNamed(_newRegister);
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

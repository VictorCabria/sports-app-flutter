import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/local_service.dart';
import '../model/configs/config_splash_screen.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import 'root_view_model.dart';

class SplashScreenViewModel
    extends RootViewModel /* 
    with GetSingleTickerProviderStateMixin  */
{
  final RoutesNavigatorService _navigatorService;

  final LocalService _localService;

  final AppConfigurationService _appConfigurationService;

  SplashScreenViewModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }
/*   Rx<FlutterGifController?> flutterGifController =
      Rx<FlutterGifController?>(null);
  Rx<GifController?> gifController = Rx<GifController?>(null); */

  int _frame = 0;
  final RxBool _register = true.obs;
  bool _gettingData = false;
  final RxBool _error = false.obs;
  final RxBool _showLogo = true.obs;
  bool _changingPage = false;
  Widget _latestFrame = Container();
  Timer? _timer;
  final RxList<String> _countries = RxList<String>();
  final RxList<String> _languages = RxList<String>();

  final Rx<ConfigSplashScreen> _configSplashScreen =
      Rx<ConfigSplashScreen>(ConfigSplashScreen());

  // getters
  bool get gettingData => _gettingData;
  RxBool get register => _register;
  RxBool get error => _error;
  RxBool get showLogo => _showLogo;
  RxList<String> get countries => _countries;
  RxList<String> get languages => _languages;
  Rx<ConfigSplashScreen> get configSplashScreen => _configSplashScreen;

  // setters
  set gettingData(bool value) {
    _gettingData = value;
  }

  @override
  refreshPage() {
    _error.value = false;
    _showLogo.value = true;
    initialize();
  }

  @override
  initialize() async {
    _localService.clear();
    Map<String, dynamic> configSet = _appConfigurationService
        .getScreenConfiguration("splashScreen") as Map<String, dynamic>;
    _configSplashScreen.value = ConfigSplashScreen.fromJson(configSet);
    getInitialData();
  }

  void getInitialData() async {
    if (_configSplashScreen.value.isImage ?? false) {
      _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
        _timer?.cancel();
        if (!gettingData && !_error.value) {
          goToLogin();
        } else {
          if (!_error.value) showProgress();
        }
      });
    }
    gettingData = true;
    //print("getting initial data");

    if (/* gifController.value?.value */ (_frame >= 100 &&
            (_configSplashScreen.value.isGif ?? false)) ||
        ((_configSplashScreen.value.isImage ?? false) &&
            !(_timer?.isActive ?? true))) {
      // 189 is the max frame of the gif
      hideProgress();
      goToLogin();
    }
  }

  Widget onFetchData(int value, Widget frame) {
    //gifController.value?.animateTo(174, duration: const Duration(seconds: 5));
    //gifController.value?.addListener(() {
    _frame = value;
    //print("frame: $value");
    //print("time: ${DateTime.now()}");
    //

    if (kIsWeb) {
      if (value == 0) {
        _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
          value = 100;
          _timer?.cancel();
          if (!gettingData && !_error.value) {
            goToLogin();
          } else {
            if (!_error.value) showProgress();
          }
        });
      }
    }

    if (/* gifController.value?. */ value >= 100) {
      //gifController.value?.stop();
      _timer?.cancel();

      _latestFrame = gettingData ? frame : _latestFrame;
      //print("gettingData: $gettingData error: $_error.value");
      if (!gettingData && !_error.value) {
        goToLogin();
      } else {
        if (!_error.value) showProgress();
      }
      return _latestFrame;
    } else {
      return frame;
    }
    //});
  }

  void goToLogin() {
    if (!_changingPage) {
      _changingPage = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        // if (_countries.length > 1) {
        //   _navigatorService.remplaceToChooseCountryLanguage();
        // } else if (_languages.length > 1) {
        //   showChooseLanguageDialog(Get.context);
        // } else {
        //   _navigatorService.remplaceToNewLogin();
        // }
        _navigatorService.remplaceToNewLogin();
      });
    }
  }
}

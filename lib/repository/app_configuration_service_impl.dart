import 'dart:convert';

import 'package:deporte_app_flutter/repository/app_configuration_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


class AppConfigurationServiceImpl extends AppConfigurationService {
  final Map<String, Map<String, dynamic>?> _configuration = {};

  AppConfigurationServiceImpl();

  String jsonFileString = """
{
  "splashScreen": {
    "available": true,
    "isGif": false,
    "isVideo": false,
    "isImage": true,
    "isLocal": true,
    "path": "lib/assets/png/sport.png"
  },
  "login": {
    "available": true,
    "multipleLogin": false,
    "isEmail": false,
    "isPhone": false,
    "isUsername": false,
    "isDocument": true,
    "showRecoveryPassword": true,
    "showRegister": true,
    "isAlphanumericPassword": true,
    "isBirthdayPassword": false

  },
  "onBoarding": {
    "available": true,
    "beforeLogin": false,
    "afterLogin": true,
    "afterRegister": false
  },
  "register": {
    "available": true,
    "isEmailValidation": false,
    "isPhoneValidation": true
  },
  "home": {
    "available": true
  }
}
""";
  @override
  init(String configurationPath) async {
    String jsonStr = "";
    if (kIsWeb) {
      jsonStr = jsonFileString;
    } else {
      jsonStr = await rootBundle.loadString(configurationPath);
    }

    final Map<String, dynamic> data = json.decode(jsonStr);
    final Map<String, Map<String, dynamic>?> configuration = {};
    data.forEach((key, value) {
      configuration[key] = value as Map<String, dynamic>?;
    });
    setConfiguration(configuration);
  }

  @override
  dynamic getConfigurationValue(String screen, String key) {
    if (_configuration.containsKey(screen)) {
      if (_configuration[screen]!.containsKey(key)) {
        return _configuration[screen]![key];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? getScreenConfiguration(String screen) {
    if (_configuration.containsKey(screen)) {
      return _configuration[screen];
    } else {
      return null;
    }
  }

  @override
  Future<void> setConfiguration(
      Map<String, Map<String, dynamic>?> configuration) {
    _configuration.clear();
    _configuration.addAll(configuration);
    return Future.value();
  }

  @override
  Iterable<String> get supportedScreens => _configuration.keys;
}

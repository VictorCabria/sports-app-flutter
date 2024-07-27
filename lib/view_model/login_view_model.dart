import 'package:deporte_app_flutter/view_model/root_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import '../domain/local_service.dart';
import '../repository/app_configuration_service.dart';
import '../routes/routes_navigator_service.dart';
import '../services/ligas_services.dart';

class LoginWidgetModel extends RootViewModel {
  final RoutesNavigatorService _navigatorService;
  final LocalService _localService;
  final AppConfigurationService _appConfigurationService;

  LoginWidgetModel(
    this._navigatorService,
    this._localService,
    this._appConfigurationService,
  ) : super(_appConfigurationService) {
    initialize();
  }

  final TextEditingController _codeController = TextEditingController();
  final RxString _apiKey = ''.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _successMessage = ''.obs;

  //getters
  TextEditingController get codeController => _codeController;
  RxString get apiKey => _apiKey;
  RxString get errorMessage => _errorMessage;
  RxString get successMessage => _successMessage;

  @override
  initialize() {}

  Future<void> setApiKey(String apiKey) async {
    if (_validateApiKey(apiKey)) {
      final response = await http.get(
        Uri.parse(
            'https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=$apiKey&from=2021-05-18&to=2021-05-18'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == '1') {
          _errorMessage.value = data['result'][0]['msg'];
          _showErrorDialog(_errorMessage.value);
        } else if (data['success'] == 1) {
          _successMessage.value = "Login successful!";
          _apiKey.value = apiKey;
          leagueServices.updateApiKey(apiKey);
          _navigatorService.remplaceAllToHome();
        }
      } else {
        _errorMessage.value = 'Failed to connect to the server';
        _showErrorDialog(_errorMessage.value);
      }
    } else {
      _errorMessage.value = "API key no es válida";
      _showErrorDialog(_errorMessage.value);
    }
  }

  void launchurl() async {
    var url = Uri.parse('https://allsportsapi.com/login');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _validateApiKey(String apiKey) {
    if (apiKey.isEmpty) {
      return false;
    }
    if (apiKey.length < 64) {
      return false;
    }

    return true;
  }

  // Nueva función para mostrar el diálogo de error
  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Get.back(); // Cierra el diálogo
            },
          ),
        ],
      ),
      barrierDismissible: false, // Evita cerrar el diálogo al tocar fuera
    );
  }
}

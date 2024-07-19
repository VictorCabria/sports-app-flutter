import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/configs/fixtures.dart';
import '../model/configs/standing.dart';
import '../model/fixtures_page.dart';
import '../model/h2hmatch_page.dart';
import '../model/standing_page.dart';

class H2HServices extends ChangeNotifier {
  static final H2HServices _instance = H2HServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory H2HServices() {
    return _instance;
  }

  H2HServices._internal() {
    _loadApiKey();
  }
  Future<void> _loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    _apiKey = prefs.getString('apiKey');
    notifyListeners();
  }

  // Método para actualizar el API key y guardarlo en SharedPreferences
  Future<void> updateApiKey(String apiKey) async {
    _apiKey = apiKey;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', apiKey);
    notifyListeners();
  }

  Future<String> _getJsonDatah2hid(
      String met, String firstTeamId, String secondTeamId) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'firstTeamId': firstTeamId.toString(),
      'secondTeamId': secondTeamId.toString(),
      'APIkey': _apiKey,
    });

    final response = await http.get(url);
    try {
      return response.body;
    } catch (e) {
      print("Error fetching data: $e");
      return "";
    }
  }

  // lista tabla con parametro de liga
  Future<H2HDetails> fetchh2h(String firstTeamId, String secondTeamId) async {
    await _loadApiKey();
    final jsonData = await _getJsonDatah2hid('H2H', firstTeamId, secondTeamId);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = H2HResult.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }
}

final H2HServices h2hServices = H2HServices();

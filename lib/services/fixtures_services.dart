import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/configs/fixtures.dart';
import '../model/fixtures_page.dart';

class FixturesServices extends ChangeNotifier {
  static final FixturesServices _instance = FixturesServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  Future<String> _getJsonData(String met) async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime tomorrow = now.add(Duration(days: 1));
    String yesterdayFormatted =
        '${yesterday.year}-${yesterday.month}-${yesterday.day}';
    String tomorrowFormatted =
        '${tomorrow.year}-${tomorrow.month}-${tomorrow.day}';

    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'APIkey': _apiKey,
      'from': yesterdayFormatted,
      'to': tomorrowFormatted,
    });

    final response = await http.get(url);
    try {
      return response.body;
    } catch (e) {
      print("Error parsing country: $e");
      return "";
    }
  }

  Future<String> _getJsonDataleagueid(String met, String leagueid) async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime tomorrow = now.add(Duration(days: 10));
    String yesterdayFormatted =
        '${yesterday.year}-${yesterday.month}-${yesterday.day}';
    String tomorrowFormatted =
        '${tomorrow.year}-${tomorrow.month}-${tomorrow.day}';

    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'APIkey': _apiKey,
      'from': yesterdayFormatted,
      'to': tomorrowFormatted,
      'leagueId': leagueid,
    });

    final response = await http.get(url);
    try {
      return response.body;
    } catch (e) {
      print("Error parsing country: $e");
      return "";
    }
  }

  factory FixturesServices() {
    return _instance;
  }

  FixturesServices._internal() {
    _loadApiKey();
  }
  Future<void> _loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    _apiKey = prefs.getString('apiKey');
    notifyListeners();
  }

  var errorMessage = ''.obs;
  var successMessage = ''.obs;


  // Método para actualizar el API key y guardarlo en SharedPreferences
  Future<void> updateApiKey(String apiKey) async {
    _apiKey = apiKey;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', apiKey);
    notifyListeners();
  }

// lista resulados en vivo
  Future<List<Fixtures>> fetchresultlive() async {
    final jsonData = await _getJsonData('Fixtures');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = FixturesResponse.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }

  // lista resulados en vivo con parametro de liga
  Future<List<Fixtures>> fetchresultliveleague(String leagueid) async {
    final jsonData = await _getJsonDataleagueid('Fixtures', leagueid);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = FixturesResponse.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }
}

final FixturesServices fixturesServices = FixturesServices();

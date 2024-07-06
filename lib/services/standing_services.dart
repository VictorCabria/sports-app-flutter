import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/configs/fixtures.dart';
import '../model/configs/standing.dart';
import '../model/fixtures_page.dart';
import '../model/standing_page.dart';

class StandingServices extends ChangeNotifier {
  static final StandingServices _instance = StandingServices._internal();
  String? _apiKey =
      "3ba1a47a78e2a1ea3d3555a90b5fb50ddf77716981a5149248478a20253eb29f";
  final String _baseUrl = 'apiv2.allsportsapi.com';

  Future<String> _getJsonDatastandingsid(String met, String leagueid) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'leagueId': leagueid,
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

  factory StandingServices() {
    return _instance;
  }

  StandingServices._internal() {
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

  // lista tabla con parametro de liga
  Future<StandingDetails> fetchstandingsleague(String leagueid) async {
    final jsonData = await _getJsonDatastandingsid('Standings', leagueid);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = StandingResult.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }
}

final StandingServices standingServices = StandingServices();

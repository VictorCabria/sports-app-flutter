import 'package:deporte_app_flutter/model/configs/player_soccer.dart';
import 'package:deporte_app_flutter/model/player_soccer_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/h2hmatch_page.dart';

class PlaySoccerServices extends ChangeNotifier {
  static final PlaySoccerServices _instance = PlaySoccerServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory PlaySoccerServices() {
    return _instance;
  }

  PlaySoccerServices._internal() {
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

  Future<String> _getJsonDatahplaySoccer(
      String met, String playerId, String leagueId) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'leagueId	': leagueId,
      'playerId': playerId,
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

  Future<String> _getJsonDatahplaySoccerlist(
      String met, String playerId) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'playerId': playerId,
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
  Future<List<PlayerSoccer>> fetchplaySoccer(
      String playerId, String leagueId) async {
    await _loadApiKey();
    final jsonData =
        await _getJsonDatahplaySoccer('Players', playerId, leagueId);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = PlayerSoccerResponse.fromJson(decodedData);
    return apiResponse.result;
  }

  Future<List<PlayerSoccer>> fetchplaySoccerlist(
    String playerId,
  ) async {
    await _loadApiKey();
    final jsonData = await _getJsonDatahplaySoccerlist('Players', playerId);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = PlayerSoccerResponse.fromJson(decodedData);
    return apiResponse.result;
  }
}

final PlaySoccerServices playSoccerServices = PlaySoccerServices();

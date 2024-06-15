import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/league.dart';
import '../model/league_page.dart';

class LeagueServices extends ChangeNotifier {
  static final LeagueServices _instance = LeagueServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory LeagueServices() {
    return _instance;
  }

  LeagueServices._internal() {
    _loadApiKey();
  }

  // Método para cargar el API key desde SharedPreferences
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

  Future<String> _getJsonData(String met) async {
    if (_apiKey == null) {
      throw Exception('API key no está configurado');
    }

    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'APIkey': _apiKey!,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error fetching data: ${response.statusCode}');
    }
  }

  Future<List<League>> fetchLeague() async {
    await _loadApiKey();
    final jsonData = await _getJsonData('Leagues');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = LeagueResponse.fromJson(decodedData);
    return apiResponse.result;
  }
}

final LeagueServices leagueServices = LeagueServices();

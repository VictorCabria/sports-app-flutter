import 'package:deporte_app_flutter/model/configs/topscorers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/configs/league.dart';
import '../model/configs/livescore.dart';
import '../model/league_page.dart';
import '../model/livescore_page.dart';
import '../model/topscorers_page.dart';

class TopsScorersServices extends ChangeNotifier {
  static final TopsScorersServices _instance = TopsScorersServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory TopsScorersServices() {
    return _instance;
  }

  TopsScorersServices._internal() {
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

  Future<String> _getJsonData(String met, String leagueid) async {
    if (_apiKey == null) {
      throw Exception('API key no está configurado');
    }

    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'leagueId': leagueid,
      'APIkey': _apiKey!,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error fetching data: ${response.statusCode}');
    }
  }

  Future<List<TopsScorers>> fetchtopscorets(String leagueid) async {
    await _loadApiKey();
    final jsonData = await _getJsonData('Topscorers', leagueid);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = TopScorersResponse.fromJson(decodedData);
    return apiResponse.result!;
  }
}

final TopsScorersServices topsScorersServices = TopsScorersServices();

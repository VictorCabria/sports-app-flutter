import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/configs/league.dart';
import '../model/configs/livescore.dart';
import '../model/league_page.dart';
import '../model/livescore_page.dart';

class LiverScoreServices extends ChangeNotifier {
  static final LiverScoreServices _instance = LiverScoreServices._internal();
  String? _apiKey;
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory LiverScoreServices() {
    return _instance;
  }

  LiverScoreServices._internal() {
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

  Future<List<LivesScore>> fetchLeague() async {
    await _loadApiKey();
    final jsonData = await _getJsonData('Livescore');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = LivesScoreResponse.fromJson(decodedData);
    return apiResponse.result;
  }
}

final LiverScoreServices liverScoreServices = LiverScoreServices();

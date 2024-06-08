import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/clasificacion.dart';
import '../model/clasificacion_page.dart';
import '../model/league.dart';
import '../model/league_page.dart';

class ClasificacionServices extends ChangeNotifier {
  final String _baseUrl = 'apiv2.allsportsapi.com';
  final String _apiKey =
      '3ca53d2bfb6b0f840e74b8c3df46b4f9e92b981bc6e73c1a799de1c202aa9c8a';

  Future<String> _getJsonData(String met, int leagueId) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'leagueId': leagueId.toString(),
      'APIkey': _apiKey,
    });

    final response = await http.get(url);
    try {
      return response.body;
    } catch (e) {
      print("Error parsing country: $e");
      return "";
    }
  }

  Future<StandingResponse> fetchStanding(int leagueId) async {
    final jsonData = await _getJsonData('Standings', leagueId);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = StandingResponse.fromJson(decodedData);
    notifyListeners();
    return apiResponse;
  }
}

final ClasificacionServices clasificacionServices = ClasificacionServices();

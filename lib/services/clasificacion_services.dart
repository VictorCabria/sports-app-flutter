import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/configs/clasificacion.dart';
import '../model/clasificacion_page.dart';
import '../model/configs/league.dart';
import '../model/league_page.dart';

class ClasificacionServices extends ChangeNotifier {
  final String _baseUrl = 'apiv2.allsportsapi.com';
  final String _apiKey =
      '4de38ab4de2775733857e7e2cb969ec1c7d108283fca8e1f08186ffd005d63cb';

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

    // Obtener el primer elemento de cada lista de clasificación
    final firstTotal = apiResponse.result.total.isNotEmpty
        ? apiResponse.result.total.first
        : null;
    final firstHome = apiResponse.result.home.isNotEmpty
        ? apiResponse.result.home.first
        : null;
    final firstAway = apiResponse.result.away.isNotEmpty
        ? apiResponse.result.away.first
        : null;

    // Crear una nueva instancia de StandingResponse solo con los primeros equipos de cada categoría
    final firstStandingResponse = StandingResponse(
      success: apiResponse.success,
      result: Result(
        total: [firstTotal!],
        home: [firstHome!],
        away: [firstAway!],
      ),
    );

    notifyListeners();
    return firstStandingResponse;
  }
}

final ClasificacionServices clasificacionServices = ClasificacionServices();

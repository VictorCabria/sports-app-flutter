import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/configs/live_result.dart';
import '../model/league_page.dart';
import '../model/live_result_page.dart';

class ResultliveServices extends ChangeNotifier {
  final String _apiKey =
      '4de38ab4de2775733857e7e2cb969ec1c7d108283fca8e1f08186ffd005d63cb'; // Reemplaza con tu clave API real
  final String _baseUrl = 'apiv2.allsportsapi.com';

  Future<String> _getJsonData(String met) async {
    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
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

// lista resulados en vivo
  Future<List<Resultlive>> fetchresultlive() async {
    final jsonData = await _getJsonData('Livescore');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = LiveResultResponse.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }
}

final ResultliveServices resultliveServices = ResultliveServices();

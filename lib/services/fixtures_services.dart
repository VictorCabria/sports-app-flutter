import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/configs/fixtures.dart';
import '../model/fixtures_page.dart';

class FixturesServices extends ChangeNotifier {
  final String _apiKey =
      '4de38ab4de2775733857e7e2cb969ec1c7d108283fca8e1f08186ffd005d63cb'; // Reemplaza con tu clave API real
  final String _baseUrl = 'apiv2.allsportsapi.com';

  Future<String> _getJsonData(String met) async {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    String todayFormatted = '${now.year}-${now.month}-${now.day}';
    String yesterdayFormatted =
        '${yesterday.year}-${yesterday.month}-${yesterday.day}';

    final url = Uri.https(_baseUrl, '/football/', {
      'met': met,
      'APIkey': _apiKey,
      'from': yesterdayFormatted,
      'to': todayFormatted,
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
  Future<List<Fixtures>> fetchresultlive() async {
    final jsonData = await _getJsonData('Fixtures');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = FixturesResponse.fromJson(decodedData);
    notifyListeners();
    return apiResponse.result;
  }
}

final FixturesServices fixturesServices = FixturesServices();

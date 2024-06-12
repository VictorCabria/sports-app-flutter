import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/country.dart';
import '../model/country_page.dart';
import 'dart:convert';

class PaisesServices extends ChangeNotifier {
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

  Future<List<Country>> fetchCountries() async {
    final jsonData = await _getJsonData('Countries');
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = PaisesResponse.fromJson(decodedData);
    notifyListeners();
     return apiResponse.result as List<Country>;
  }
}

final PaisesServices paisesServices = PaisesServices();

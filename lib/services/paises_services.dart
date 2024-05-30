import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/country.dart';
import '../model/country_page.dart';
import 'dart:convert';

class PaisesServices extends ChangeNotifier {
  final String _apiKey =
      '3ca53d2bfb6b0f840e74b8c3df46b4f9e92b981bc6e73c1a799de1c202aa9c8a'; // Reemplaza con tu clave API real
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

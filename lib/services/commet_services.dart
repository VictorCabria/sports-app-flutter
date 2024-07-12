import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/configs/comment.dart';
import '../model/configs/league.dart';
import '../model/configs/livescore.dart';
import '../model/league_page.dart';
import '../model/livescore_page.dart';

class CommentsServices extends ChangeNotifier {
  static final CommentsServices _instance = CommentsServices._internal();
  String? _apiKey =
      'd7911ec5753a307f58bf6522d5cfaae38824130f26d6cfb06f1fbe053a1c7fa2';
  final String _baseUrl = 'apiv2.allsportsapi.com';

  factory CommentsServices() {
    return _instance;
  }

  CommentsServices._internal() {
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

  Future<String> _getJsonData(String met, String matchId) async {
    if (_apiKey == null) {
      throw Exception('API key no está configurado');
    }

    final url = Uri.https(_baseUrl, '/football/',
        {'met': met, 'APIkey': _apiKey!, 'matchId': matchId});

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error fetching data: ${response.statusCode}');
    }
  }

  Future<List<Comment>?> fetchcomment(String matchId) async {
    final jsonData = await _getJsonData('Comments', matchId);
    final Map<String, dynamic> decodedData = json.decode(jsonData);
    final apiResponse = CommentResponse.fromJson(decodedData, matchId);
    return apiResponse.result;
  }
}

final CommentsServices commentsServices = CommentsServices();

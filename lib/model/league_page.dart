import 'package:deporte_app_flutter/model/configs/league.dart';

class LeagueResponse {
  final int success;
  final List<League> result;

  LeagueResponse({
    required this.success,
    required this.result,
  });

  factory LeagueResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<League> leaguesList = list.map((i) => League.fromJson(i)).toList();

    return LeagueResponse(
      success: json['success'],
      result: leaguesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.map((league) => league.toJson()).toList(),
    };
  }
}

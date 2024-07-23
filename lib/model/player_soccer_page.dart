import 'package:deporte_app_flutter/model/configs/player_soccer.dart';

class PlayerSoccerResponse {
  final int success;
  final List<PlayerSoccer> result;

  PlayerSoccerResponse({
    required this.success,
    required this.result,
  });

  factory PlayerSoccerResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<PlayerSoccer> leaguesList =
        list.map((i) => PlayerSoccer.fromJson(i)).toList();

    return PlayerSoccerResponse(
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

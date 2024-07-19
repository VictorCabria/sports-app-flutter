class TopsScorers {
  final int? playerPlace;
  final String? playerName;
  final int? playerKey;
  final String? teamName;
  final int? teamKey;
  final int? goals;
  final int? assists; // Usar int? para permitir null
  final int? penaltyGoals;

  TopsScorers({
    required this.playerPlace,
    required this.playerName,
    required this.playerKey,
    required this.teamName,
    required this.teamKey,
    required this.goals,
    this.assists,
    required this.penaltyGoals,
  });

  factory TopsScorers.fromJson(Map<String, dynamic> json) {
    return TopsScorers(
      playerPlace: json['player_place'] as int,
      playerName: json['player_name'] as String,
      playerKey: json['player_key'],
      teamName: json['team_name'],
      teamKey: json['team_key'],
      goals: json['goals'],
      assists: json['assists'],
      penaltyGoals: json['penalty_goals'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_place': playerPlace,
      'player_name': playerName,
      'player_key': playerKey,
      'team_name': teamName,
      'team_key': teamKey,
      'goals': goals,
      'assists': assists,
      'penalty_goals': penaltyGoals,
    };
  }
}

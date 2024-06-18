class Resultlive {
  final int? eventKey;
  final String? eventDate;
  final String? eventTime;
  final String? eventHomeTeam;
  final int? homeTeamKey;
  final String? eventAwayTeam;
  final int? awayTeamKey;
  final String? eventHalftimeResult;
  final String?eventFinalResult;
  final String? eventFtResult;
  final String? eventPenaltyResult;
  final String? eventStatus;
  final String? countryName;
  final String? leagueName;
  final int? leagueKey;
  final String? leagueRound;
  final String? leagueSeason;
  final String? eventLive;
  final String? eventStadium;
  final String? eventReferee;
  final String? homeTeamLogo;
  final String? awayTeamLogo;
  final String? eventHomeFormation;
   final String? eventAwayFormation;
  final int? fkStageKey;
  final String? stageName;
  final String? leagueGroup;
  /*  final List<GoalScorer>? goalscorers;
   final List<Substitute>? substitutes; 
     final List<Card>? cards;  
   final Vars? vars;
  final Lineups? lineups;
  final List<Statistic>? statistics;  */

  Resultlive({
    required this.eventKey,
    required this.eventDate,
    required this.eventTime,
    required this.eventHomeTeam,
    required this.homeTeamKey,
    required this.eventAwayTeam,
    required this.awayTeamKey,
    required this.eventHalftimeResult,
    required this.eventFinalResult,
    required this.eventFtResult,
    required this.eventPenaltyResult,
    required this.eventStatus,
    required this.countryName,
    required this.leagueName,
    required this.leagueKey,
    required this.leagueRound,
    required this.leagueSeason,
    required this.eventLive,
    required this.eventStadium,
    required this.eventReferee,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.eventHomeFormation,
     required this.eventAwayFormation,
    required this.fkStageKey,
    required this.stageName,
    required this.leagueGroup,
    /* required this.goalscorers,
     required this.substitutes, 
       required this.cards,  
     required this.vars,
    required this.lineups,
    required this.statistics,   */
  });

  factory Resultlive.fromJson(Map<String, dynamic> json) {
    return Resultlive(
      eventKey: json['event_key'],
      eventDate: json['event_date'],
      eventTime: json['event_time'],
      eventHomeTeam: json['event_home_team'],
      homeTeamKey: json['home_team_key'],
      eventAwayTeam: json['event_away_team'],
      awayTeamKey: json['away_team_key'],
      eventHalftimeResult: json['event_halftime_result'],
      eventFinalResult: json['event_final_result'],
      eventFtResult: json['event_ft_result'],
      eventPenaltyResult: json['event_penalty_result'],
      eventStatus: json['event_status'],
      countryName: json['country_name'],
      leagueName: json['league_name'],
      leagueKey: json['league_key'],
      leagueRound: json['league_round'],
      leagueSeason: json['league_season'],
      eventLive: json['event_live'],
      eventStadium: json['event_stadium'],
      eventReferee: json['event_referee'],
      homeTeamLogo: json['home_team_logo'],
      awayTeamLogo: json['away_team_logo'],
      eventHomeFormation: json['event_home_formation'],
      eventAwayFormation: json['event_away_formation'],
      fkStageKey: json['fk_stage_key'],
       stageName: json['stage_name'],
      leagueGroup: json['league_group'],
      /* goalscorers: (json['goalscorers'] as List).map((i) => GoalScorer.fromJson(i)).toList(),
        substitutes: (json['substitutes'] as List).map((i) => Substitute.fromJson(i)).toList(), 
       cards: (json['cards'] as List).map((i) => Card.fromJson(i)).toList(), 
       vars: Vars.fromJson(json['vars']),
      lineups: Lineups.fromJson(json['lineups']),
      statistics: (json['statistics'] as List).map((i) => Statistic.fromJson(i)).toList(),   */
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_key': eventKey,
      'event_date': eventDate,
      'event_time': eventTime,
      'event_home_team': eventHomeTeam,
      'home_team_key': homeTeamKey,
      'event_away_team': eventAwayTeam,
      'away_team_key': awayTeamKey,
      'event_halftime_result': eventHalftimeResult,
      'event_final_result': eventFinalResult,
      'event_ft_result': eventFtResult,
      'event_penalty_result': eventPenaltyResult,
      'event_status': eventStatus,
      'country_name': countryName,
      'league_name': leagueName,
      'league_key': leagueKey,
      'league_round': leagueRound,
      'league_season': leagueSeason,
      'event_live': eventLive,
      'event_stadium': eventStadium,
      'event_referee': eventReferee,
      'home_team_logo': homeTeamLogo,
      'away_team_logo': awayTeamLogo,
      'event_home_formation': eventHomeFormation,
       'event_away_formation': eventAwayFormation,
      'fk_stage_key': fkStageKey,
      'stage_name': stageName,
      'league_group': leagueGroup,
     /*  'goalscorers': goalscorers?.map((i) => i.toJson()).toList(),
        'substitutes': substitutes?.map((i) => i.toJson()).toList(), 
      'cards': cards?.map((i) => i.toJson()).toList(), 
       'vars': vars?.toJson(),
      'lineups': lineups?.toJson(),
      'statistics': statistics?.map((i) => i.toJson()).toList(), */  
    };
  }
}

class GoalScorer {
  final String? time;
  final String? homeScorer;
  final String? homeScorerId;
  final String? homeAssist;
  final String? homeAssistId;
  final String? score;
  final String? awayScorer;
  final String? awayScorerId;
  final String? awayAssist;
  final String? awayAssistId;
  final String? info;
  final String? infoTime;

  GoalScorer({
    required this.time,
    required this.homeScorer,
    required this.homeScorerId,
    required this.homeAssist,
    required this.homeAssistId,
    required this.score,
    required this.awayScorer,
    required this.awayScorerId,
    required this.awayAssist,
    required this.awayAssistId,
    required this.info,
    required this.infoTime,
  });

  factory GoalScorer.fromJson(Map<String, dynamic> json) {
    return GoalScorer(
      time: json['time'],
      homeScorer: json['home_scorer'],
      homeScorerId: json['home_scorer_id'],
      homeAssist: json['home_assist'],
      homeAssistId: json['home_assist_id'],
      score: json['score'],
      awayScorer: json['away_scorer'],
      awayScorerId: json['away_scorer_id'],
      awayAssist: json['away_assist'],
      awayAssistId: json['away_assist_id'],
      info: json['info'],
      infoTime: json['info_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'home_scorer': homeScorer,
      'home_scorer_id': homeScorerId,
      'home_assist': homeAssist,
      'home_assist_id': homeAssistId,
      'score': score,
      'away_scorer': awayScorer,
      'away_scorer_id': awayScorerId,
      'away_assist': awayAssist,
      'away_assist_id': awayAssistId,
      'info': info,
      'info_time': infoTime,
    };
  }
}

class Substitute {
  final String? time;
  final Substitution? homeScorer;
  final String? homeAssist;
  final String? score;
  final List<Substitution>? awayScorer;
  final String? awayAssist;
  final String? info;
  final String? infoTime;

  Substitute({
    required this.time,
    required this.homeScorer,
    required this.homeAssist,
    required this.score,
    required this.awayScorer,
    required this.awayAssist,
    required this.info,
    required this.infoTime,
  });

  factory Substitute.fromJson(Map<String, dynamic> json) {
    return Substitute(
      time: json['time'],
      homeScorer: Substitution.fromJson(json['home_scorer']),
      homeAssist: json['home_assist'],
      score: json['score'],
      awayScorer: (json['away_scorer'] as List).map((i) => Substitution.fromJson(i)).toList(),
      awayAssist: json['away_assist'],
      info: json['info'],
      infoTime: json['info_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'home_scorer': homeScorer?.toJson(),
      'home_assist': homeAssist,
      'score': score,
      'away_scorer': awayScorer?.map((i) => i.toJson()).toList(),
      'away_assist': awayAssist,
      'info': info,
      'info_time': infoTime,
    };
  }
}

class Substitution {
  final String? time;
  final String? substitution;

  Substitution({
    required this.time,
    required this.substitution,
  });

  factory Substitution.fromJson(Map<String, dynamic> json) {
    return Substitution(
      time: json['time'],
      substitution: json['substitution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'substitution': substitution,
    };
  }
}

class Card {
  final String? time;
  final String? homeFault;
  final String? card;
  final String? awayFault;
  final String? info;
  final String? homePlayerId;
  final String? awayPlayerId;
  final String? infoTime;

  Card({
    required this.time,
    required this.homeFault,
    required this.card,
    required this.awayFault,
    required this.info,
    required this.homePlayerId,
    required this.awayPlayerId,
    required this.infoTime,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      time: json['time'],
      homeFault: json['home_fault'],
      card: json['card'],
      awayFault: json['away_fault'],
      info: json['info'],
      homePlayerId: json['home_player_id'],
      awayPlayerId: json['away_player_id'],
      infoTime: json['info_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'home_fault': homeFault,
      'card': card,
      'away_fault': awayFault,
      'info': info,
      'home_player_id': homePlayerId,
      'away_player_id': awayPlayerId,
      'info_time': infoTime,
    };
  }
}

class Vars {
  final List<Var>? home;
  final List<Var>? away;

  Vars({
    required this.home,
    required this.away,
  });

  factory Vars.fromJson(Map<String, dynamic> json) {
    return Vars(
      home: (json['home'] as List).map((i) => Var.fromJson(i)).toList(),
      away: (json['away'] as List).map((i) => Var.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home?.map((i) => i.toJson()).toList(),
      'away': away?.map((i) => i.toJson()).toList(),
    };
  }
}

class Var {
  final String? eventMinute;
  final String? eventTeam;
  final String? eventType;
  final String? varResult;
  final String? varDecision;
  final String? varPlayer;
  final String? varType;
  final String? varEventDecision;
  final String? varMinute;
  final String? varPlayerId;

  Var({
    required this.eventMinute,
    required this.eventTeam,
    required this.eventType,
    required this.varResult,
    required this.varDecision,
    required this.varPlayer,
    required this.varType,
    required this.varEventDecision,
    required this.varMinute,
    required this.varPlayerId,
  });

  factory Var.fromJson(Map<String, dynamic> json) {
    return Var(
      eventMinute: json['event_minute'],
      eventTeam: json['event_team'],
      eventType: json['event_type'],
      varResult: json['var_result'],
      varDecision: json['var_decision'],
      varPlayer: json['var_player'],
      varType: json['var_type'],
      varEventDecision: json['var_event_decision'],
      varMinute: json['var_minute'],
      varPlayerId: json['var_player_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_minute': eventMinute,
      'event_team': eventTeam,
      'event_type': eventType,
      'var_result': varResult,
      'var_decision': varDecision,
      'var_player': varPlayer,
      'var_type': varType,
      'var_event_decision': varEventDecision,
      'var_minute': varMinute,
      'var_player_id': varPlayerId,
    };
  }
}

class Lineups {
  final List<Player>? homeTeam;
  final List<Player>? awayTeam;

  Lineups({
    required this.homeTeam,
    required this.awayTeam,
  });

  factory Lineups.fromJson(Map<String, dynamic> json) {
    return Lineups(
      homeTeam: (json['home_team'] as List).map((i) => Player.fromJson(i)).toList(),
      awayTeam: (json['away_team'] as List).map((i) => Player.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home_team': homeTeam?.map((i) => i.toJson()).toList(),
      'away_team': awayTeam?.map((i) => i.toJson()).toList(),
    };
  }
}

class Player {
  final String? playerKey;
  final String? playerName;
  final String? playerNumber;
  final String? playerCountry;
  final String? playerType;
  final String? playerAge;
  final String? playerMatchPlayed;
  final String? playerGoals;
  final String? playerYellowCards;
  final String? playerRedCards;

  Player({
    required this.playerKey,
    required this.playerName,
    required this.playerNumber,
    required this.playerCountry,
    required this.playerType,
    required this.playerAge,
    required this.playerMatchPlayed,
    required this.playerGoals,
    required this.playerYellowCards,
    required this.playerRedCards,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerKey: json['player_key'],
      playerName: json['player_name'],
      playerNumber: json['player_number'],
      playerCountry: json['player_country'],
      playerType: json['player_type'],
      playerAge: json['player_age'],
      playerMatchPlayed: json['player_match_played'],
      playerGoals: json['player_goals'],
      playerYellowCards: json['player_yellow_cards'],
      playerRedCards: json['player_red_cards'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_key': playerKey,
      'player_name': playerName,
      'player_number': playerNumber,
      'player_country': playerCountry,
      'player_type': playerType,
      'player_age': playerAge,
      'player_match_played': playerMatchPlayed,
      'player_goals': playerGoals,
      'player_yellow_cards': playerYellowCards,
      'player_red_cards': playerRedCards,
    };
  }
}

class Statistic {
  final String? type;
  final String? home;
  final String? away;

  Statistic({
    required this.type,
    required this.home,
    required this.away,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      type: json['type'],
      home: json['home'],
      away: json['away'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'home': home,
      'away': away,
    };
  }
}

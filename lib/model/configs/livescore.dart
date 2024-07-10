class LivesScore {
  final int? eventKey;
  final String? eventDate;
  final String? eventTime;
  final String? eventHomeTeam;
  final int? homeTeamKey;
  final String? eventAwayTeam;
  final int? awayTeamKey;
  final String? eventHalftimeResult;
  final String? eventFinalResult;
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
  final String? leaguelogo;
  final String? countrylogo;
  final String? awayTeamLogo;
  final String? eventHomeFormation;
  final String? eventAwayFormation;
  final int? fkStageKey;
  final String? stageName;
  final String? leagueGroup;
  final List<GoalScorer>? goalscorers;
  final List<Statistic>? statistics;
  final Lineups? lineups;
/*   final Lineups? lineups; */
  /* final List<Substitute>? substitutes; 
     final List<Card>? cards;  
   final Vars? vars;
  final Lineups? lineups;  */

  LivesScore({
    this.eventKey,
    this.eventDate,
    this.eventTime,
    this.eventHomeTeam,
    this.homeTeamKey,
    this.eventAwayTeam,
    this.awayTeamKey,
    this.eventHalftimeResult,
    this.eventFinalResult,
    this.eventFtResult,
    this.eventPenaltyResult,
    this.eventStatus,
    this.countryName,
    this.leagueName,
    this.leagueKey,
    this.leagueRound,
    this.leagueSeason,
    this.eventLive,
    this.leaguelogo,
    this.countrylogo,
    this.eventStadium,
    this.eventReferee,
    this.homeTeamLogo,
    this.awayTeamLogo,
    this.eventHomeFormation,
    this.eventAwayFormation,
    this.fkStageKey,
    this.stageName,
    this.leagueGroup,
    this.goalscorers,
    this.statistics,
    this.lineups,

    /*  required this.substitutes, 
       required this.cards,  
     required this.vars,

      */
  });

  factory LivesScore.fromJson(Map<String, dynamic> json) {
    return LivesScore(
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
      leaguelogo: json["league_logo"],
      countrylogo: json["country_logo"],
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
      goalscorers: (json['goalscorers'] as List)
          .map((i) => GoalScorer.fromJson(i))
          .toList(),
      statistics: (json['statistics'] as List)
          .map((i) => Statistic.fromJson(i))
          .toList(),
      lineups: Lineups.fromJson(json['lineups']),
      /*   lineups: Lineups.fromJson(json['lineups']), */
      /*   substitutes: (json['substitutes'] as List).map((i) => Substitute.fromJson(i)).toList(), 
       cards: (json['cards'] as List).map((i) => Card.fromJson(i)).toList(), 
       vars: Vars.fromJson(json['vars']),
    */
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
      'league_logo': leaguelogo,
      'country_logo': countrylogo,
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
      'goalscorers': goalscorers?.map((i) => i.toJson()).toList(),
      'statistics': statistics?.map((i) => i.toJson()).toList(),
      'lineups': lineups?.toJson(),
      /*  'substitutes': substitutes?.map((i) => i.toJson()).toList(), 
      'cards': cards?.map((i) => i.toJson()).toList(), 
       'vars': vars?.toJson(),
      */
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
      awayScorer: (json['away_scorer'] as List)
          .map((i) => Substitution.fromJson(i))
          .toList(),
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
  final List<Player>? homesubstitutes;
  final List<Player>? awaysubstitutes;
  final List<Coaches>? homecoaches;
  final List<Coaches>? awaycoaches;

  Lineups(
      {this.homeTeam,
      this.awayTeam,
      this.homesubstitutes,
      this.awaysubstitutes,
      this.homecoaches,
      this.awaycoaches});

  factory Lineups.fromJson(Map<String, dynamic> json) {
    return Lineups(
      homeTeam: (json['home_team']['starting_lineups'] as List)
          .map((i) => Player.fromJson(i))
          .toList(),
      awayTeam: (json['away_team']['starting_lineups'] as List)
          .map((i) => Player.fromJson(i))
          .toList(),
      homesubstitutes: (json['home_team']['substitutes'] as List)
          .map((i) => Player.fromJson(i))
          .toList(),
      awaysubstitutes: (json['away_team']['substitutes'] as List)
          .map((i) => Player.fromJson(i))
          .toList(),
      homecoaches: (json['home_team']['coaches'] as List)
          .map((i) => Coaches.fromJson(i))
          .toList(),
      awaycoaches: (json['away_team']['coaches'] as List)
          .map((i) => Coaches.fromJson(i))
          .toList(),
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
  final String? player;
  final int? playerNumber;
  final int? playerPosition;
  final String? playerCountry;
  final int? playerKey;
  final String? infoTime;

  Player({
    this.player,
    this.playerNumber,
    this.playerPosition,
    this.playerCountry,
    this.playerKey,
    this.infoTime,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      player: json['player'],
      playerNumber: json['player_number'],
      playerPosition: json['player_position'],
      playerCountry: json['player_country'],
      playerKey: json['player_key'],
      infoTime: json['info_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player': player,
      'player_number': playerNumber,
      'player_position': playerPosition,
      'player_country': playerCountry,
      'player_key': playerKey,
      'info_time': infoTime,
    };
  }
}

class Coaches {
  final String? coache;

  Coaches({
    this.coache,
  });

  factory Coaches.fromJson(Map<String, dynamic> json) {
    return Coaches(
      coache: json['coache'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coache': coache,
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

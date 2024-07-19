class H2HMatch {
  int? eventKey;
  String? eventDate;
  String? eventTime;
  String? eventHomeTeam;
  int? homeTeamKey;
  String? eventAwayTeam;
  int? awayTeamKey;
  String? homeTeamLogo;
  String? awayTeamLogo;
  String? eventHalftimeResult;
  String? eventFinalResult;
  String? eventStatus;
  String? countryName;
  String? leagueName;
  int? leagueKey;
  String? leagueRound;
  String? leagueSeason;
  String? eventLive;
  int? eventCountryKey;

  H2HMatch({
    required this.eventKey,
    required this.eventDate,
    required this.eventTime,
    required this.eventHomeTeam,
    required this.homeTeamKey,
    required this.eventAwayTeam,
    required this.awayTeamKey,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.eventHalftimeResult,
    required this.eventFinalResult,
    required this.eventStatus,
    required this.countryName,
    required this.leagueName,
    required this.leagueKey,
    required this.leagueRound,
    required this.leagueSeason,
    required this.eventLive,
    required this.eventCountryKey,
  });

  factory H2HMatch.fromJson(Map<String, dynamic> json) {
    return H2HMatch(
      eventKey: json['event_key'],
      eventDate: json['event_date'],
      eventTime: json['event_time'],
      eventHomeTeam: json['event_home_team'],
      homeTeamKey: json['home_team_key'],
      eventAwayTeam: json['event_away_team'],
      awayTeamKey: json['away_team_key'],
      homeTeamLogo: json['home_team_logo'],
      awayTeamLogo: json['away_team_logo'],
      eventHalftimeResult: json['event_halftime_result'],
      eventFinalResult: json['event_final_result'],
      eventStatus: json['event_status'],
      countryName: json['country_name'],
      leagueName: json['league_name'],
      leagueKey: json['league_key'],
      leagueRound: json['league_round'],
      leagueSeason: json['league_season'],
      eventLive: json['event_live'],
      eventCountryKey: json['event_country_key'],
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
      'home_team_logo': homeTeamLogo,
      'away_team_logo': awayTeamLogo,
      'event_halftime_result': eventHalftimeResult,
      'event_final_result': eventFinalResult,
      'event_status': eventStatus,
      'country_name': countryName,
      'league_name': leagueName,
      'league_key': leagueKey,
      'league_round': leagueRound,
      'league_season': leagueSeason,
      'event_live': eventLive,
      'event_country_key': eventCountryKey,
    };
  }
}

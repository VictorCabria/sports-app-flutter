class Standing {
  final int? standingPlace;
  final String? standingPlaceType;
  final String? standingTeam;
  final int? standingP;
  final int? standingW;
  final int? standingD;
  final int? standingL;
  final int? standingF;
  final int? standingA;
  final int? standingGD;
  final int? standingPTS;
  final int? teamKey;
  final int? leagueKey;
  final String? leagueSeason;
  final String? leagueRound;
  final String? standingUpdated;
  final int? fkStageKey;
  final String? stageName;
  final String? teamLogo;
  final int? standingLP;
  final int? standingWP;

  Standing({
    required this.standingPlace,
    required this.standingPlaceType,
    required this.standingTeam,
    required this.standingP,
    required this.standingW,
    required this.standingD,
    required this.standingL,
    required this.standingF,
    required this.standingA,
    required this.standingGD,
    required this.standingPTS,
    required this.teamKey,
    required this.leagueKey,
    required this.leagueSeason,
    required this.leagueRound,
    required this.standingUpdated,
    required this.fkStageKey,
    required this.stageName,
    required this.teamLogo,
    required this.standingLP,
    required this.standingWP,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      standingPlace: json['standing_place'],
      standingPlaceType: json['standing_place_type'],
      standingTeam: json['standing_team'],
      standingP: json['standing_P'],
      standingW: json['standing_W'],
      standingD: json['standing_D'],
      standingL: json['standing_L'],
      standingF: json['standing_F'],
      standingA: json['standing_A'],
      standingGD: json['standing_GD'],
      standingPTS: json['standing_PTS'],
      teamKey: json['team_key'],
      leagueKey: json['league_key'],
      leagueSeason: json['league_season'],
      leagueRound: json['league_round'],
      standingUpdated: json['standing_updated'],
      fkStageKey: json['fk_stage_key'],
      stageName: json['stage_name'],
      teamLogo: json['team_logo'],
      standingLP: json['standing_LP'],
      standingWP: json['standing_WP'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standing_place': standingPlace,
      'standing_place_type': standingPlaceType,
      'standing_team': standingTeam,
      'standing_P': standingP,
      'standing_W': standingW,
      'standing_D': standingD,
      'standing_L': standingL,
      'standing_F': standingF,
      'standing_A': standingA,
      'standing_GD': standingGD,
      'standing_PTS': standingPTS,
      'team_key': teamKey,
      'league_key': leagueKey,
      'league_season': leagueSeason,
      'league_round': leagueRound,
      'standing_updated': standingUpdated,
      'fk_stage_key': fkStageKey,
      'stage_name': stageName,
      'team_logo': teamLogo,
      'standing_LP': standingLP,
      'standing_WP': standingWP,
    };
  }
}

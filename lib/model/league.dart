class League {
  final int? leagueKey;
  final String? leagueName;
  final int? countryKey;
  final String? countryName;
  final String? leagueLogo;
  final String? countryLogo;

  League({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    required this.leagueLogo,
    this.countryLogo,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueKey: json['league_key'],
      leagueName: json['league_name'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      leagueLogo: json['league_logo'],
      countryLogo: json['country_logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league_key': leagueKey,
      'league_name': leagueName,
      'country_key': countryKey,
      'country_name': countryName,
      'league_logo': leagueLogo,
      'country_logo': countryLogo,
    };
  }
}

class Country {
   int? countryKey;
   String? countryName;
   String? countryIso2;
   String? countryLogo;

  Country({
    required this.countryKey,
    required this.countryName,
    this.countryIso2,
    required this.countryLogo,
  });
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryKey: json['country_key'],
      countryName: json['country_name'],
      countryIso2: json['country_iso2'],
      countryLogo: json['country_logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_key': countryKey,
      'country_name': countryName,
      'country_iso2': countryIso2,
      'country_logo': countryLogo,
    };
  }
}

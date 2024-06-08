import 'package:deporte_app_flutter/model/clasificacion.dart';

class StandingResponse {
  final int success;
  final Result result;

  StandingResponse({
    required this.success,
    required this.result,
  });

  factory StandingResponse.fromJson(Map<String, dynamic> json) {
    return StandingResponse(
      success: json['success'],
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.toJson(),
    };
  }
}

class Result {
  final List<Standing> total;
  final List<Standing> home;
  final List<Standing> away;

  Result({
    required this.total,
    required this.home,
    required this.away,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    var totalList = json['total'] as List;
    var homeList = json['home'] as List;
    var awayList = json['away'] as List;

    List<Standing> totalStandingList =
        totalList.map((e) => Standing.fromJson(e)).toList();
    List<Standing> homeStandingList =
        homeList.map((e) => Standing.fromJson(e)).toList();
    List<Standing> awayStandingList =
        awayList.map((e) => Standing.fromJson(e)).toList();

    return Result(
      total: totalStandingList,
      home: homeStandingList,
      away: awayStandingList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total.map((standing) => standing.toJson()).toList(),
      'home': home.map((standing) => standing.toJson()).toList(),
      'away': away.map((standing) => standing.toJson()).toList(),
    };
  }
}


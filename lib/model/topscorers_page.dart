import 'package:deporte_app_flutter/model/configs/topscorers.dart';

class TopScorersResponse {
  final int? success;
  final List<TopsScorers>? result;

  TopScorersResponse({
    required this.success,
    required this.result,
  });

  factory TopScorersResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<TopsScorers> leaguesList =
        list.map((i) => TopsScorers.fromJson(i)).toList();

    return TopScorersResponse(
      success: json['success'],
      result: leaguesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result!.map((league) => league.toJson()).toList(),
    };
  }
}

import 'package:deporte_app_flutter/model/configs/standing.dart';

class StandingResult {
  final int? success;
  final StandingDetails result;

  StandingResult({
    required this.success,
    required this.result,
  });

  factory StandingResult.fromJson(Map<String, dynamic> json) {
    return StandingResult(
      success: json['success'],
      result: StandingDetails.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.toJson(),
    };
  }
}

class StandingDetails {
  final List<Standing>? total;

  StandingDetails({
    required this.total,
  });

  factory StandingDetails.fromJson(Map<String, dynamic> json) {
    var totalList = json['total'] as List;
    List<Standing> standings =
        totalList.map((e) => Standing.fromJson(e)).toList();
    return StandingDetails(
      total: standings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total!.map((e) => e.toJson()).toList(),
    };
  }
}

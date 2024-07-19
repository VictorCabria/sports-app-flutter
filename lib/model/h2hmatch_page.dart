import 'package:deporte_app_flutter/model/configs/h2hmatch.dart';
import 'package:deporte_app_flutter/model/configs/standing.dart';

class H2HResult {
  final int? success;
  final H2HDetails result;

  H2HResult({
    required this.success,
    required this.result,
  });

  factory H2HResult.fromJson(Map<String, dynamic> json) {
    return H2HResult(
      success: json['success'],
      result: H2HDetails.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.toJson(),
    };
  }
}

class H2HDetails {
  final List<H2HMatch>? h2h;

  H2HDetails({
    required this.h2h,
  });

  factory H2HDetails.fromJson(Map<String, dynamic> json) {
    var totalList = json['H2H'] as List;
    List<H2HMatch> standings =
        totalList.map((e) => H2HMatch.fromJson(e)).toList();
    return H2HDetails(
      h2h: standings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'H2H': h2h!.map((e) => e.toJson()).toList(),
    };
  }
}

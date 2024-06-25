import 'package:deporte_app_flutter/model/configs/fixtures.dart';

class FixturesResponse {
  final int success;
  final List<Fixtures> result;

 FixturesResponse({
    required this.success,
    required this.result,
  });

  factory FixturesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<Fixtures> fixturestist = list.map((i) => Fixtures.fromJson(i)).toList();

    return FixturesResponse(
      success: json['success'],
      result: fixturestist,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.map((fixturestist) => fixturestist.toJson()).toList(),
    };
  }
}

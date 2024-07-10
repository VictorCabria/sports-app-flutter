
import 'package:deporte_app_flutter/model/configs/livescore.dart';

class LivesScoreResponse {
  final int success;
  final List<LivesScore> result;

 LivesScoreResponse({
    required this.success,
    required this.result,
  });

  factory LivesScoreResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<LivesScore> fixturestist = list.map((i) => LivesScore.fromJson(i)).toList();

    return LivesScoreResponse(
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

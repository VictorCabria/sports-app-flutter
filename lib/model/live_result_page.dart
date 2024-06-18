import 'package:deporte_app_flutter/model/configs/live_result.dart';

class LiveResultResponse {
  final int success;
  final List<Resultlive> result;

  LiveResultResponse({
    required this.success,
    required this.result,
  });

  factory LiveResultResponse.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<Resultlive> liveresultist = list.map((i) => Resultlive.fromJson(i)).toList();

    return LiveResultResponse(
      success: json['success'],
      result: liveresultist,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.map((liveresult) => liveresult.toJson()).toList(),
    };
  }
}

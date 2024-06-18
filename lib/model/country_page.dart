import 'package:deporte_app_flutter/model/configs/country.dart';

class PaisesResponse {
   int? success;
   List<Country>? result;

  PaisesResponse({
    required this.success,
    required this.result,
  });

  factory PaisesResponse.fromJson(Map<String, dynamic> json) {
    return PaisesResponse(
      success: json['success'],
      result:
          List<Country>.from(json['result'].map((x) => Country.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': List<dynamic>.from(result!.map((x) => x.toJson())),
    };
  }
}

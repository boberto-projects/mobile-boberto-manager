import 'dart:convert';

import 'package:equatable/equatable.dart';

class GenerateOtpResponse extends Equatable {
  final String? code;

  const GenerateOtpResponse({this.code});

  factory GenerateOtpResponse.fromMap(Map<String, dynamic> data) {
    return GenerateOtpResponse(
      code: data['code'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GenerateOtpResponse].
  factory GenerateOtpResponse.fromJson(String data) {
    return GenerateOtpResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GenerateOtpResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code];
}

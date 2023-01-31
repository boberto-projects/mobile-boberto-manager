import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidateOtpRequest extends Equatable {
  final String? code;

  const ValidateOtpRequest({this.code});

  factory ValidateOtpRequest.fromMap(Map<String, dynamic> data) {
    return ValidateOtpRequest(
      code: data['code'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ValidateOtpRequest].
  factory ValidateOtpRequest.fromJson(String data) {
    return ValidateOtpRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ValidateOtpRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code];
}

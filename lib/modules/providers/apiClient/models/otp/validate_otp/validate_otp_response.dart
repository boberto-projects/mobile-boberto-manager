import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidateOtpResponse extends Equatable {
  final int? passoDeTempo;
  final bool? valido;

  const ValidateOtpResponse({this.passoDeTempo, this.valido});

  factory ValidateOtpResponse.fromMap(Map<String, dynamic> data) {
    return ValidateOtpResponse(
      passoDeTempo: data['passoDeTempo'] as int?,
      valido: data['valido'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'passoDeTempo': passoDeTempo,
        'valido': valido,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ValidateOtpResponse].
  factory ValidateOtpResponse.fromJson(String data) {
    return ValidateOtpResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ValidateOtpResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [passoDeTempo, valido];
}

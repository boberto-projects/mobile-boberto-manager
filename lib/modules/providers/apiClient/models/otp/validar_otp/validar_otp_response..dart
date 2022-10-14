import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidarOtpResponse extends Equatable {
  final int? passoDeTempo;
  final bool? valido;

  const ValidarOtpResponse({this.passoDeTempo, this.valido});

  factory ValidarOtpResponse.fromMap(Map<String, dynamic> data) {
    return ValidarOtpResponse(
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
  /// Parses the string and returns the resulting Json object as [ValidarOtpResponse].
  factory ValidarOtpResponse.fromJson(String data) {
    return ValidarOtpResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ValidarOtpResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [passoDeTempo, valido];
}

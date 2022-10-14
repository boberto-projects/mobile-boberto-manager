import 'dart:convert';

import 'package:equatable/equatable.dart';

class EnviarCodigoSmsRequest extends Equatable {
  final String? numeroCelular;

  const EnviarCodigoSmsRequest({this.numeroCelular});

  factory EnviarCodigoSmsRequest.fromMap(Map<String, dynamic> data) {
    return EnviarCodigoSmsRequest(
      numeroCelular: data['numeroCelular'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'numeroCelular': numeroCelular,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EnviarCodigoSmsRequest].
  factory EnviarCodigoSmsRequest.fromJson(String data) {
    return EnviarCodigoSmsRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EnviarCodigoSmsRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [numeroCelular];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class EnviarCodigoSmsRequest extends Equatable {
  final String numeroCelular;
  const EnviarCodigoSmsRequest({
    required this.numeroCelular,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numeroCelular': numeroCelular,
    };
  }

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
  List<Object> get props => [numeroCelular];

  EnviarCodigoSmsRequest copyWith({
    String? numeroCelular,
  }) {
    return EnviarCodigoSmsRequest(
      numeroCelular: numeroCelular ?? this.numeroCelular,
    );
  }

  factory EnviarCodigoSmsRequest.fromMap(Map<String, dynamic> map) {
    return EnviarCodigoSmsRequest(
      numeroCelular: map['numeroCelular'] as String,
    );
  }


  @override
  bool get stringify => true;
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidarOtpRequest extends Equatable {
  final String? codigo;

  const ValidarOtpRequest({this.codigo});

  factory ValidarOtpRequest.fromMap(Map<String, dynamic> data) {
    return ValidarOtpRequest(
      codigo: data['codigo'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'codigo': codigo,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ValidarOtpRequest].
  factory ValidarOtpRequest.fromJson(String data) {
    return ValidarOtpRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ValidarOtpRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [codigo];
}

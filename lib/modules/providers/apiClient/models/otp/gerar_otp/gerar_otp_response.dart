import 'dart:convert';

import 'package:equatable/equatable.dart';

class GerarOtpResponse extends Equatable {
  final String? codigo;

  const GerarOtpResponse({this.codigo});

  factory GerarOtpResponse.fromMap(Map<String, dynamic> data) {
    return GerarOtpResponse(
      codigo: data['codigo'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'codigo': codigo,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GerarOtpResponse].
  factory GerarOtpResponse.fromJson(String data) {
    return GerarOtpResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GerarOtpResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [codigo];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class EnviarCodigoEmailRequest extends Equatable {
  final String? email;

  const EnviarCodigoEmailRequest({this.email});

  factory EnviarCodigoEmailRequest.fromMap(Map<String, dynamic> data) {
    return EnviarCodigoEmailRequest(
      email: data['email'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EnviarCodigoEmailRequest].
  factory EnviarCodigoEmailRequest.fromJson(String data) {
    return EnviarCodigoEmailRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EnviarCodigoEmailRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [email];
}

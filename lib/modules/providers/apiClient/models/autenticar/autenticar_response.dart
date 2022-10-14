import 'dart:convert';

import 'package:equatable/equatable.dart';

class AutenticarResponse extends Equatable {
  final String? token;
  final bool? duplaAutenticacaoObrigatoria;

  const AutenticarResponse({this.token, this.duplaAutenticacaoObrigatoria});

  factory AutenticarResponse.fromMap(Map<String, dynamic> data) {
    return AutenticarResponse(
      token: data['token'] as String?,
      duplaAutenticacaoObrigatoria:
          data['duplaAutenticacaoObrigatoria'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'token': token,
        'duplaAutenticacaoObrigatoria': duplaAutenticacaoObrigatoria,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AutenticarResponse].
  factory AutenticarResponse.fromJson(String data) {
    return AutenticarResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AutenticarResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [token, duplaAutenticacaoObrigatoria];
}

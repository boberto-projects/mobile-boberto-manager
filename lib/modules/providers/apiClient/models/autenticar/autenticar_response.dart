// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AutenticarResponse extends Equatable {
  final String token;
  final bool duplaAutenticacaoObrigatoria;

  const AutenticarResponse({
    required this.token,
    required this.duplaAutenticacaoObrigatoria,
  });

  AutenticarResponse copyWith({
    String? token,
    bool? duplaAutenticacaoObrigatoria,
  }) {
    return AutenticarResponse(
      token: token ?? this.token,
      duplaAutenticacaoObrigatoria:
          duplaAutenticacaoObrigatoria ?? this.duplaAutenticacaoObrigatoria,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'duplaAutenticacaoObrigatoria': duplaAutenticacaoObrigatoria,
    };
  }

  factory AutenticarResponse.fromMap(Map<String, dynamic> map) {
    return AutenticarResponse(
      token: map['token'] as String,
      duplaAutenticacaoObrigatoria: map['duplaAutenticacaoObrigatoria'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutenticarResponse.fromJson(String source) =>
      AutenticarResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token, duplaAutenticacaoObrigatoria];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AutenticarResponse extends Equatable {
  final String token;
  final bool duplaAutenticacaoObrigatoria;
  final String? tipo;
  final String expiraEm;
  const AutenticarResponse({
    required this.token,
    required this.duplaAutenticacaoObrigatoria,
    this.tipo,
    required this.expiraEm,
  });

  AutenticarResponse copyWith({
    String? token,
    bool? duplaAutenticacaoObrigatoria,
    String? tipo,
    String? expiraEm,
  }) {
    return AutenticarResponse(
      token: token ?? this.token,
      duplaAutenticacaoObrigatoria:
          duplaAutenticacaoObrigatoria ?? this.duplaAutenticacaoObrigatoria,
      tipo: tipo ?? this.tipo,
      expiraEm: expiraEm ?? this.expiraEm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'duplaAutenticacaoObrigatoria': duplaAutenticacaoObrigatoria,
      'tipo': tipo,
      'expiraEm': expiraEm,
    };
  }

  factory AutenticarResponse.fromMap(Map<String, dynamic> map) {
    return AutenticarResponse(
      token: map['token'] as String,
      duplaAutenticacaoObrigatoria: map['duplaAutenticacaoObrigatoria'] as bool,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      expiraEm: map['expiraEm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutenticarResponse.fromJson(String source) =>
      AutenticarResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [token, duplaAutenticacaoObrigatoria, tipo!, expiraEm];
}

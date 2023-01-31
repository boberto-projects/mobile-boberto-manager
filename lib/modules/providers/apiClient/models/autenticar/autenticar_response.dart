// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class authenticatorResponse extends Equatable {
  final String token;
  final bool pairAuthenticationEnabled;
  final String? tipo;
  final String expiraEm;
  const authenticatorResponse({
    required this.token,
    required this.pairAuthenticationEnabled,
    this.tipo,
    required this.expiraEm,
  });

  authenticatorResponse copyWith({
    String? token,
    bool? pairAuthenticationEnabled,
    String? tipo,
    String? expiraEm,
  }) {
    return authenticatorResponse(
      token: token ?? this.token,
      pairAuthenticationEnabled:
          pairAuthenticationEnabled ?? this.pairAuthenticationEnabled,
      tipo: tipo ?? this.tipo,
      expiraEm: expiraEm ?? this.expiraEm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'pairAuthenticationEnabled': pairAuthenticationEnabled,
      'tipo': tipo,
      'expiraEm': expiraEm,
    };
  }

  factory authenticatorResponse.fromMap(Map<String, dynamic> map) {
    return authenticatorResponse(
      token: map['token'] as String,
      pairAuthenticationEnabled: map['pairAuthenticationEnabled'] as bool,
      tipo: map['tipo'] != null ? map['tipo'] as String : null,
      expiraEm: map['expiraEm'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory authenticatorResponse.fromJson(String source) => authenticatorResponse
      .fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token, pairAuthenticationEnabled, tipo!, expiraEm];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class AutenticarRequest extends Equatable {
  final String? email;
  final String? senha;
  final String? codigo;

  const AutenticarRequest({this.email, this.senha, this.codigo});

  factory AutenticarRequest.fromMap(Map<String, dynamic> data) {
    return AutenticarRequest(
      email: data['email'] as String?,
      senha: data['senha'] as String?,
      codigo: data['codigo'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'senha': senha,
        'codigo': codigo,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AutenticarRequest].
  factory AutenticarRequest.fromJson(String data) {
    return AutenticarRequest.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AutenticarRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [email, senha, codigo];
}

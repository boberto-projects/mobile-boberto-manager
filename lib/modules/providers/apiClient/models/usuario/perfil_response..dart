import 'dart:convert';

import 'package:equatable/equatable.dart';

class PerfilResponse extends Equatable {
  final int? id;
  final String? email;
  final String? numeroCelular;
  final String? nome;
  final bool? usarEmail;
  final bool? usarNumeroCelular;

  const PerfilResponse({
    this.id,
    this.email,
    this.numeroCelular,
    this.nome,
    this.usarEmail,
    this.usarNumeroCelular,
  });

  factory PerfilResponse.fromMap(Map<String, dynamic> data) {
    return PerfilResponse(
      id: data['id'] as int?,
      email: data['email'] as String?,
      numeroCelular: data['numeroCelular'] as String?,
      nome: data['nome'] as String?,
      usarEmail: data['usarEmail'] as bool?,
      usarNumeroCelular: data['usarNumeroCelular'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'numeroCelular': numeroCelular,
        'nome': nome,
        'usarEmail': usarEmail,
        'usarNumeroCelular': usarNumeroCelular,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PerfilResponse].
  factory PerfilResponse.fromJson(String data) {
    return PerfilResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PerfilResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      id,
      email,
      numeroCelular,
      nome,
      usarEmail,
      usarNumeroCelular,
    ];
  }
}

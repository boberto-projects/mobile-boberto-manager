// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomExceptionResponse extends Equatable {
  final String tipo;
  final String mensagem;
  const CustomExceptionResponse({
    required this.tipo,
    required this.mensagem,
  });

  CustomExceptionResponse copyWith({
    String? tipo,
    String? mensagem,
  }) {
    return CustomExceptionResponse(
      tipo: tipo ?? this.tipo,
      mensagem: mensagem ?? this.mensagem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
      'mensagem': mensagem,
    };
  }

  factory CustomExceptionResponse.fromMap(Map<String, dynamic> map) {
    return CustomExceptionResponse(
      tipo: map['tipo'] as String,
      mensagem: map['mensagem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomExceptionResponse.fromJson(String source) =>
      CustomExceptionResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [tipo, mensagem];
}

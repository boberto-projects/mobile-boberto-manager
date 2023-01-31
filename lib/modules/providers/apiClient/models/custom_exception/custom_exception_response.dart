// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomExceptionResponse extends Equatable {
  final String type;
  final String message;
  const CustomExceptionResponse({
    required this.type,
    required this.message,
  });

  CustomExceptionResponse copyWith({
    String? type,
    String? message,
  }) {
    return CustomExceptionResponse(
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'message': message,
    };
  }

  factory CustomExceptionResponse.fromMap(Map<String, dynamic> map) {
    return CustomExceptionResponse(
      type: map['type'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomExceptionResponse.fromJson(String source) =>
      CustomExceptionResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, message];
}

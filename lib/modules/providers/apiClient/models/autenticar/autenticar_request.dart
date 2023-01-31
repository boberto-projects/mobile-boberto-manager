import 'dart:convert';

import 'package:equatable/equatable.dart';

class authenticatorRequest extends Equatable {
  final String? email;
  final String? password;
  final String? code;

  const authenticatorRequest({this.email, this.password, this.code});

  factory authenticatorRequest.fromMap(Map<String, dynamic> data) {
    return authenticatorRequest(
      email: data['email'] as String?,
      password: data['password'] as String?,
      code: data['code'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [authenticatorRequest].
  factory authenticatorRequest.fromJson(String data) {
    return authenticatorRequest
        .fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [authenticatorRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [email, password, code];
}

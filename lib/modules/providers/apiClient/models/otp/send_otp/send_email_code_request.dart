import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendEmailCodeRequest extends Equatable {
  final String? email;

  const SendEmailCodeRequest({this.email});

  factory SendEmailCodeRequest.fromMap(Map<String, dynamic> data) {
    return SendEmailCodeRequest(
      email: data['email'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'email': email,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SendEmailCodeRequest].
  factory SendEmailCodeRequest.fromJson(String data) {
    return SendEmailCodeRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SendEmailCodeRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [email];
}

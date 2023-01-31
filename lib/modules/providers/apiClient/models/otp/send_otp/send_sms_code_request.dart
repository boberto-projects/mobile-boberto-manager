// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendSmsCodeRequest extends Equatable {
  final String phoneNumber;
  const SendSmsCodeRequest({
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SendSmsCodeRequest].
  factory SendSmsCodeRequest.fromJson(String data) {
    return SendSmsCodeRequest.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SendSmsCodeRequest] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [phoneNumber];

  SendSmsCodeRequest copyWith({
    String? phoneNumber,
  }) {
    return SendSmsCodeRequest(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory SendSmsCodeRequest.fromMap(Map<String, dynamic> map) {
    return SendSmsCodeRequest(
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  @override
  bool get stringify => true;
}

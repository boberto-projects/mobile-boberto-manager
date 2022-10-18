// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class InterceptorModel {
  String? url;
  String? method;
  dynamic response;
  dynamic request;
  int? statusCode;

  Map<String, dynamic>? headers;
  Map<String, dynamic>? queryParams;
  InterceptorModel({
    this.url,
    this.method,
    this.response,
    this.request,
    this.statusCode,
    this.headers,
    this.queryParams,
  });

  InterceptorModel copyWith({
    String? url,
    String? method,
    dynamic response,
    dynamic request,
    int? statusCode,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) {
    return InterceptorModel(
      url: url ?? this.url,
      method: method ?? this.method,
      response: response ?? this.response,
      request: request ?? this.request,
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      queryParams: queryParams ?? this.queryParams,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'method': method,
      'response': response ?? "No content",
      'request': request ?? "No content",
      'statusCode': statusCode,
      'headers': headers,
      'queryParams': queryParams,
    };
  }

  factory InterceptorModel.fromMap(Map<String, dynamic> map) {
    return InterceptorModel(
      url: map['url'] != null ? map['url'] as String : null,
      method: map['method'] != null ? map['method'] as String : null,
      response: map['response'] as dynamic,
      request: map['request'] as dynamic,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      headers: map['headers'] != null
          ? Map<String, dynamic>.from((map['headers'] as Map<String, dynamic>))
          : null,
      queryParams: map['queryParams'] != null
          ? Map<String, dynamic>.from(
              (map['queryParams'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterceptorModel.fromJson(String source) =>
      InterceptorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InterceptorModel(url: $url, method: $method, response: $response, request: $request, statusCode: $statusCode, headers: $headers, queryParams: $queryParams)';
  }

  void toConsoleLog({String? titulo = ""}) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String jsonMap = encoder.convert(toMap());
    print(titulo);
    print(jsonMap);
  }

  @override
  bool operator ==(covariant InterceptorModel other) {
    if (identical(this, other)) return true;

    return other.url == url &&
        other.method == method &&
        other.response == response &&
        other.request == request &&
        other.statusCode == statusCode &&
        mapEquals(other.headers, headers) &&
        mapEquals(other.queryParams, queryParams);
  }

  @override
  int get hashCode {
    return url.hashCode ^
        method.hashCode ^
        response.hashCode ^
        request.hashCode ^
        statusCode.hashCode ^
        headers.hashCode ^
        queryParams.hashCode;
  }
}

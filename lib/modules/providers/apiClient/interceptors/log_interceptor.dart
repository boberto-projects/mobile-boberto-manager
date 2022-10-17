import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var apiUrl = options.baseUrl + options.path;
    print(apiUrl);
    print(options.method);
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(options.data);
    print(prettyprint);
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("onResponse");
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print("onError: ${err.response?.statusCode}");
    return handler.next(err); // <--- THE TIP IS HERE
  }
}

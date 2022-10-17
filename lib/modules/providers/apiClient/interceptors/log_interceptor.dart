import 'dart:async';

import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("onRequest");
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

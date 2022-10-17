import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var titulo = '${options.baseUrl}${options.path} [${options.method}]';
    print(titulo);
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(options.data);
    print(prettyprint);
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("RESPOSTA");
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(response.data);
    print(prettyprint);
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var titulo = 'OCORREU UM ERRO [${err.response?.statusCode}]';
    print(titulo);
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(err.response?.data);
    print(prettyprint);
    return handler.next(err); // <--- THE TIP IS HERE
  }
}

import 'dart:async';
import 'package:auth_otp_test/modules/providers/apiClient/interceptors/models/inteceptor_model.dart';
import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var model = InterceptorModel(
        url: '${options.baseUrl}${options.path}',
        method: options.method,
        request: options.data,
        headers: options.headers,
        queryParams: options.queryParameters);
    model.toConsoleLog(titulo: "Request");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    var model = InterceptorModel(
        method: response.requestOptions.method,
        response: response.data,
        headers: response.headers.map,
        statusCode: response.statusCode,
        queryParams: response.requestOptions.queryParameters);
    model.toConsoleLog(titulo: "Response");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var model = InterceptorModel(
        method: err.requestOptions.method,
        statusCode: err.response?.statusCode,
        response: err.response?.data,
        headers: err.response?.headers.map,
        queryParams: err.requestOptions.queryParameters);
    model.toConsoleLog(titulo: "OCORREU UM ERRO");
    return handler.next(err); // <--- THE TIP IS HERE
  }
}

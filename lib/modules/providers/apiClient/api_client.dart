import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/interceptors/log_interceptor.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/custom_exception/custom_exception_response.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'models/autenticar/autenticar_request.dart';
import 'models/autenticar/autenticar_response.dart';
import 'models/otp/enviar_otp/enviar_codigo_email_request.dart';
import 'models/otp/enviar_otp/enviar_codigo_sms_request.dart';
import 'models/otp/gerar_otp/gerar_otp_response.dart';
import 'models/otp/validar_otp/validar_otp_request.dart';
import 'models/otp/validar_otp/validar_otp_response..dart';
import 'models/usuario/perfil_response..dart';

class ApiClient extends GetxService {
  static Dio _dio = Dio();

  Future<Dio> _obterApiClient() async {
    bool usuarioLogado = false;
    String? chaveJWT =
        await SecureStorage.obterValor(AppConfig.autenticacaoJWTChave);
    usuarioLogado = chaveJWT != null;
    _dio = Dio();
    _dio.options.headers.clear();
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _dio.options.baseUrl = AppConfig.apiUrl;
    _dio.interceptors.add(LoggingInterceptors());

    if (usuarioLogado) {
      _dio.options.headers["Authorization"] = "Bearer $chaveJWT";
    } else {
      _dio.options.headers[AppConfig.apiKeyHeader] = AppConfig.apiKey;
    }

    return _dio;
  }

  ///
  ///Autenticação
  ///
  Future<Either<CustomExceptionResponse, AutenticarResponse>> autenticar(
      AutenticarRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.post('/autenticar', data: request.toMap());
      return right(AutenticarResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(CustomExceptionResponse.fromMap(exception.response?.data));
    }
  }

  ///
  /// Perfil
  ///

  Future<Either<CustomExceptionResponse, PerfilResponse>> obterPerfil() async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.get('/perfil');
      return right(PerfilResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(CustomExceptionResponse.fromMap(exception.response?.data));
    }
  }

  ///
  /// NÃO SERA USADA DEPRECATED
  ///

  Future<Either<CustomExceptionResponse, ValidarOtpResponse>> validarCodigoOtp(
      ValidarOtpRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.post('/validarotp', data: request.toMap());
      return right(ValidarOtpResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(CustomExceptionResponse.fromMap(exception.response?.data));
    }
  }

  ///
  /// NÃO SERA USADA DEPRECATED
  ///
  Future<Either<Exception, GerarOtpResponse>> gerarCodigoOtp() async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.post('/gerarotp');
      return right(GerarOtpResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoSMS(
      EnviarCodigoSmsRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response =
          await apiClient.post('/enviarcodigosms', data: request.toMap());
      return right(response.statusCode == 200);
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoEmail(
      EnviarCodigoEmailRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response =
          await apiClient.post('/enviarcodigoemail', data: request.toMap());
      return right(response.statusCode == 200);
    } on DioError catch (exception) {
      return left(exception);
    }
  }
}

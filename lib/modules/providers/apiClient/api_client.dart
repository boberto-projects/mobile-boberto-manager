import 'package:auth_otp_test/app_config.dart';
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
  Future<Dio> _obterApiClient() async {
    Dio dio = Dio();
    bool usuarioLogado = false;
    dio.options.headers.clear();
    dio.options.receiveDataWhenStatusError = true;
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.baseUrl = AppConfig.apiUrl;
    String? chaveJWT =
        await SecureStorage.obterValor(AppConfig.autenticacaoJWTChave);
    usuarioLogado = chaveJWT != null;

    if (usuarioLogado) {
      dio.options.headers["Authorization"] = "Bearer $chaveJWT";
    } else {
      dio.options.headers[AppConfig.apiKeyHeader] = AppConfig.apiKey;
    }

    return dio;
  }

  ///
  ///Autenticação
  ///
  Future<Either<Exception, AutenticarResponse>> autenticar(
      AutenticarRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      return apiClient
          .post('/autenticar', data: request.toMap())
          .then((res) => right(AutenticarResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  ///
  /// Perfil
  ///

  Future<Either<Exception, PerfilResponse>> obterPerfil() async {
    try {
      Dio apiClient = await _obterApiClient();
      return apiClient
          .get('/perfil')
          .then((res) => right(PerfilResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  ///
  /// Rotas de OTP
  ///

  Future<Either<Exception, ValidarOtpResponse>> validarCodigoOtp(
      ValidarOtpRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();

      return apiClient
          .post('/validarotp', data: request.toMap())
          .then((res) => right(ValidarOtpResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, GerarOtpResponse>> gerarCodigoOtp() async {
    try {
      Dio apiClient = await _obterApiClient();
      return apiClient
          .post('/gerarotp')
          .then((res) => right(GerarOtpResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoSMS(
      EnviarCodigoSmsRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      return apiClient
          .post('/enviarcodigosms', data: request.toMap())
          .then((res) => right(res.statusCode == 200));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoEmail(
      EnviarCodigoEmailRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      return apiClient
          .post('/enviarcodigosms', data: request.toMap())
          .then((res) => right(res.statusCode == 200));
    } on DioError catch (exception) {
      return left(exception);
    }
  }
}

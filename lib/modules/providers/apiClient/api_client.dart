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
  late Dio dio;
  late SecureStorage storage;
  late Options defaultOptions;

  ApiClient() {
    dio = Dio();
    storage = SecureStorage();
    dio.options.baseUrl = AppConfig.apiUrl;
    bool usuarioLogado = storage.chaveExiste(AppConfig.autenticacaoJWTChave);

    if (usuarioLogado) {
      defaultOptions = Options(headers: {
        "Authorization":
            "Bearer ${storage.obterValor(AppConfig.autenticacaoJWTChave)}"
      });
    } else {
      defaultOptions =
          Options(headers: {AppConfig.apiKeyHeader: AppConfig.apiKey});
    }
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.headers['content-Type'] = 'application/json';
  }

  ///
  ///Autenticação
  ///
  Future<Either<Exception, AutenticarResponse>> autenticar(
      AutenticarRequest request) async {
    try {
      return dio
          .post('/autenticar', data: request.toMap(), options: defaultOptions)
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
      return dio
          .get('/perfil', options: defaultOptions)
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
      return dio
          .post('/validarotp', data: request.toMap(), options: defaultOptions)
          .then((res) => right(ValidarOtpResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, GerarOtpResponse>> gerarCodigoOtp() async {
    try {
      return dio
          .post('/gerarotp', options: defaultOptions)
          .then((res) => right(GerarOtpResponse.fromMap(res.data)));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoSMS(
      EnviarCodigoSmsRequest request) async {
    try {
      return dio
          .post('/enviarcodigosms',
              data: request.toMap(), options: defaultOptions)
          .then((res) => right(res.statusCode == 200));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> enviarCodigoEmail(
      EnviarCodigoEmailRequest request) async {
    try {
      return dio
          .post('/enviarcodigosms',
              data: request.toMap(), options: defaultOptions)
          .then((res) => right(res.statusCode == 200));
    } on DioError catch (exception) {
      return left(exception);
    }
  }
}

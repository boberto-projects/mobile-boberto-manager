import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
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
    bool usuarioLogado = storage.chaveExiste(AppConfig.usuarioTokenJWT);

    if (usuarioLogado) {
      defaultOptions = Options(headers: {
        "Authorization":
            "Bearer ${storage.obterValor(AppConfig.usuarioTokenJWT)}"
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
  Future<AutenticarResponse> autenticar(AutenticarRequest request) async {
    return dio
        .post('/autenticar', data: request.toMap(), options: defaultOptions)
        .then((res) => AutenticarResponse.fromMap(res.data));
  }

  ///
  /// Perfil
  ///

  Future<PerfilResponse> obterPerfil() async {
    return dio
        .get('/perfil', options: defaultOptions)
        .then((res) => PerfilResponse.fromMap(res.data));
  }

  ///
  /// Rotas de OTP
  ///

  Future<ValidarOtpResponse> validarCodigoOtp(ValidarOtpRequest request) async {
    return dio
        .post('/validarotp', data: request.toMap(), options: defaultOptions)
        .then((res) => ValidarOtpResponse.fromMap(res.data));
  }

  Future<GerarOtpResponse> gerarCodigoOtp() async {
    return dio
        .post('/gerarotp', options: defaultOptions)
        .then((res) => GerarOtpResponse.fromMap(res.data));
  }

  Future<bool> enviarCodigoSMS(EnviarCodigoSmsRequest request) async {
    return dio
        .post('/enviarcodigosms',
            data: request.toMap(), options: defaultOptions)
        .then((res) => res.statusCode == 200);
  }

  Future<bool> enviarCodigoEmail(EnviarCodigoEmailRequest request) async {
    return dio
        .post('/enviarcodigosms',
            data: request.toMap(), options: defaultOptions)
        .then((res) => res.statusCode == 200);
  }
}

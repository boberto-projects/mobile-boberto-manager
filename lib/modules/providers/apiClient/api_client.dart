import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/interceptors/log_interceptor.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_response.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/custom_exception/custom_exception_response.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/generate_otp/generate_otp_response.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/validate_otp/validate_otp_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/validate_otp/validate_otp_response.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'models/otp/send_otp/send_email_code_request.dart';
import 'models/otp/send_otp/send_sms_code_request.dart';
import 'models/usuario/perfil_response..dart';

class ApiClient extends GetxService {
  static Dio _dio = Dio();

  Future<Dio> _obterApiClient() async {
    bool usuarioLogado = false;
    String? chaveJWT =
        await SecureStorage.get(AppConfig.authenticationJWTBaerer);
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
  Future<Either<CustomExceptionResponse, authenticatorResponse>> authenticator(
      authenticatorRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response =
          await apiClient.post('/authenticator', data: request.toMap());
      return right(authenticatorResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(CustomExceptionResponse.fromMap(exception.response?.data));
    }
  }

  ///
  /// Perfil
  ///

  Future<Either<CustomExceptionResponse, PerfilResponse>> getProfile() async {
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

  Future<Either<CustomExceptionResponse, ValidateOtpResponse>> validateOtpCode(
      ValidateOtpRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.post('/validarotp', data: request.toMap());
      return right(ValidateOtpResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(CustomExceptionResponse.fromMap(exception.response?.data));
    }
  }

  ///
  /// NÃO SERA USADA DEPRECATED
  ///
  Future<Either<Exception, GenerateOtpResponse>> generateOtpCode() async {
    try {
      Dio apiClient = await _obterApiClient();
      var response = await apiClient.post('/gerarotp');
      return right(GenerateOtpResponse.fromMap(response.data));
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> sendSMSCode(
      SendSmsCodeRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response =
          await apiClient.post('/otp/sendSMSCode', data: request.toMap());
      return right(response.statusCode == 200);
    } on DioError catch (exception) {
      return left(exception);
    }
  }

  Future<Either<Exception, bool>> sendEmailCode(
      SendEmailCodeRequest request) async {
    try {
      Dio apiClient = await _obterApiClient();
      var response =
          await apiClient.post('/otp/sendEmailCode', data: request.toMap());
      return right(response.statusCode == 200);
    } on DioError catch (exception) {
      return left(exception);
    }
  }
}

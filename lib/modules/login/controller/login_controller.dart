// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/send_otp/send_email_code_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/send_otp/send_sms_code_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:auth_otp_test/modules/providers/services/otp_service.dart';
import 'package:auth_otp_test/modules/providers/services/sms_service.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);
  final Rx<bool> pairAuthenticationEnabled = Rx<bool>(false);
  final Rx<bool> showError = Rx<bool>(false);
  final Rx<String> messageError = Rx<String>("");
  final Rx<int> intervalTimeResend = Rx<int>(AppConfig.otpInterval);
  final apiClient = Get.find<ApiClient>();
  final smsService = Get.find<SMSService>();
  final otpService = Get.find<OtpService>();

  Timer? intervalResend;

  //mock
  LoginController() {
    emailTextController.text = "robertocpaes@gmail.com";
    passwordTextController.text = "Teste@123";
  }
  void _removeMessageError() {
    showError.value = false;
    messageError.value = "";
  }

  void _showErrorMessage(String message) {
    showError.value = true;
    messageError.value = message;
  }

  Future<void> authenticator() async {
    _removeMessageError();
    final email = emailTextController.text;
    final password = passwordTextController.text;
    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage("Preencha todos os dados.");
      return;
    }
    final request = authenticatorRequest(
        email: email, password: password, code: otpService.getCode);
    await SecureStorage.delete(AppConfig.authenticationJWTBaerer);
    var response = await apiClient.authenticator(request);
    response.fold((onError) async {
      _showErrorMessage(onError.message);
      otpService.clear();
      if (onError.type == "code_otp_nao_informado") {
        Get.toNamed('/loginotp');
      }
    }, (response) async {
      SecureStorage.write(AppConfig.authenticationJWTBaerer, response.token);

      if (response.pairAuthenticationEnabled) {
        pairAuthenticationEnabled.value = response.pairAuthenticationEnabled;
        var perfilRequest = await apiClient.getProfile();
        perfilRequest.fold((onError) {
          _showErrorMessage("Dados inválidos.");
        }, (getProfileResponse) {
          perfil.value = getProfileResponse;
          SecureStorage.delete(AppConfig.authenticationJWTBaerer);
          Get.toNamed('/loginotp');
        });
        return;
      }
      Get.toNamed("/perfil");
    });
  }

  void startInterval() {
    if (intervalResend != null) {
      return;
    }
    intervalResend = Timer.periodic(const Duration(seconds: 1), (timer) async {
      intervalTimeResend.value--;
      if (intervalTimeResend.value == 0) {
        intervalTimeResend.value = AppConfig.otpInterval;
        timer.cancel();
      }
    });
  }

  void sendAndWaitSMS() async {
    startInterval();
    await sendSMSCode();
    await smsService.waitSMS((smsRecebido) {
      bool codeValido = otpService.validate(smsRecebido);
      if (codeValido) {
        authenticator();
      }
    });
  }

  Future sendSMSCode() async {
    var sendSMSCodeRequest = await apiClient.sendSMSCode(
        SendSmsCodeRequest(phoneNumber: perfil.value?.numeroCelular ?? ""));
    sendSMSCodeRequest.fold((onError) {
      _showErrorMessage("Ocorreu um erro ao enviar SMS.");
    }, (sendSMSCodeResponse) {
      startInterval();
    });
  }

  @override
  void dispose() {
    super.dispose();
    intervalResend?.cancel();
  }
}

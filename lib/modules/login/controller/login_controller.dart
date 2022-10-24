// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/enviar_otp/enviar_codigo_sms_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:auth_otp_test/modules/providers/services/otp_service.dart';
import 'package:auth_otp_test/modules/providers/services/sms_service.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);
  final Rx<bool> duplaAutenticacaoObrigatoria = Rx<bool>(false);
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final Rx<int> tempoIntervaloReenviar = Rx<int>(AppConfig.otpIntervalo);
  final apiClient = Get.find<ApiClient>();
  final smsService = Get.find<SMSService>();
  final otpService = Get.find<OtpService>();

  Timer? intervaloReenviar;

  //mock
  LoginController() {
    emailTextController.text = "robertocpaes@gmail.com";
    senhaTextController.text = "Teste@123";
  }
  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mostrarErro.value = true;
    mensagemErro.value = mensagem;
  }

  /// TODO: TEMOS QUE FASEAR O LOGIN.
  /// A autenticação usando OTP é opcional caso o usuário não a ative.
  /// Entretanto, o login no aplicativo será faseado entre login_view e otp_view

  Future<void> autenticar() async {
    _removerMensagemDeErro();
    final email = emailTextController.text;
    final senha = senhaTextController.text;
    if (email.isEmpty || senha.isEmpty) {
      _mostrarMensagemDeErro("Preencha todos os dados.");
      return;
    }
    final request = AutenticarRequest(
        email: email, senha: senha, codigo: otpService.obterCodigoOTP);
    await SecureStorage.deletarValor(AppConfig.autenticacaoJWTChave);
    var response = await apiClient.autenticar(request);
    response.fold((onError) async {
      _mostrarMensagemDeErro(onError.mensagem);
      otpService.limparCodigoOTP();
      if (onError.tipo == "codigo_otp_nao_informado") {
        Get.toNamed('/loginotp');
      }
    }, (response) async {
      SecureStorage.escreverValor(
          AppConfig.autenticacaoJWTChave, response.token);

      if (response.duplaAutenticacaoObrigatoria) {
        duplaAutenticacaoObrigatoria.value =
            response.duplaAutenticacaoObrigatoria;
        var perfilRequest = await apiClient.obterPerfil();
        perfilRequest.fold((onError) {
          _mostrarMensagemDeErro("Dados inválidos.");
        }, (obterPerfilResponse) {
          perfil.value = obterPerfilResponse;
          SecureStorage.deletarValor(AppConfig.autenticacaoJWTChave);
          Get.toNamed('/loginotp');
        });
        return;
      }
      Get.toNamed("/perfil");
    });
  }

  void iniciarIntervalo() {
    if (intervaloReenviar != null) {
      return;
    }
    intervaloReenviar =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      tempoIntervaloReenviar.value--;
      if (tempoIntervaloReenviar.value == 0) {
        tempoIntervaloReenviar.value = AppConfig.otpIntervalo;
        timer.cancel();
      }
    });
  }

  void enviarEAguardarSMS() async {
    iniciarIntervalo();
    await enviarCodigoSMS();
    await smsService.aguardarSMS((smsRecebido) {
      bool codigoValido = otpService.validarCodigoOTP(smsRecebido);
      if (codigoValido) {
        autenticar();
      }
    });
  }

  Future enviarCodigoSMS() async {
    var enviarCodigoSMSRequest = await apiClient.enviarCodigoSMS(
        EnviarCodigoSmsRequest(
            numeroCelular: perfil.value?.numeroCelular ?? ""));
    enviarCodigoSMSRequest.fold((onError) {
      _mostrarMensagemDeErro("Ocorreu um erro ao enviar SMS.");
    }, (enviarCodigoSMSResponse) {
      iniciarIntervalo();
    });
  }

  @override
  void dispose() {
    super.dispose();
    intervaloReenviar?.cancel();
  }
}

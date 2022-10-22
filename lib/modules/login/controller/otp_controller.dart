import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final String titulo = "Fluxo otp";
  final List<TextEditingController> pinCodeList = [];
  String secretKeyOtp = AppConfig.otpKey;
  int otpSize = AppConfig.otpTamanho;
  int intervalo = AppConfig.otpIntervalo;

  OtpController() {
    for (var i = 0; i < otpSize; i++) {
      pinCodeList.add(TextEditingController());
    }
  }

  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mensagemErro.value = mensagem;
    mostrarErro.value = true;
  }

  Future<void> solicitarCodigoOTP() async {
    final apiClient = ApiClient();
    try {
      //a api enviará um SMS para o número do usuário registrado.
      await apiClient.gerarCodigoOtp();
    } catch (exception) {
      _mostrarMensagemDeErro("Código inválido");
    }
  }

  String get obterCodigoOTP => pinCodeList.fold(
      "", (previousValue, element) => previousValue + element.text);

  Future<void> validarCodigoOTP() async {
    _removerMensagemDeErro();
    String code = obterCodigoOTP;

    if (code.isEmpty || code.length < otpSize) {
      _mostrarMensagemDeErro("É necessário informar um código.");
      return;
    }
    print("codigo otp alterado");

    TOTP totp = TOTP(secret: secretKeyOtp, interval: intervalo);
    var verificaCodigo = totp.verify(otp: code);
    if (verificaCodigo == false) {
      _mostrarMensagemDeErro("Código inválido");
    }
  }

  void preencherCodigoOTP(String codigo) {
    String codigoTratado = codigo.replaceAll(RegExp(r'[A-Za-z]'), '');
    if (codigoTratado.isEmpty || codigoTratado.length > otpSize) return;
    var codigoToChars = codigoTratado.split("");
    for (var i = 0; i < codigoToChars.length; i++) {
      pinCodeList[i].text = codigoToChars[i];
    }
  }

  Future<void> colarCodigoOTP() async {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      String codigoColado = value?.text ?? "";
      preencherCodigoOTP(codigoColado);
    });
  }
}

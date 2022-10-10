import 'package:auth_otp_test/modules/dio/api_client.dart';
import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final List<TextEditingController> pinCodeList = [];
  String secretKeyOtp = "J22U6B3WIWRRBTAV";
  int otpSize = 6;

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
      await apiClient.gerarCodigoOTP();
    } catch (exception) {
      _mostrarMensagemDeErro("Código inválido");
    }
  }

  Future<void> validarCodigoOTP() async {
    _removerMensagemDeErro();
    String code = pinCodeList.fold(
        "", (previousValue, element) => previousValue + element.text);

    if (code.isEmpty || code.length > otpSize) {
      _mostrarMensagemDeErro("É necessário informar um código.");
      return;
    }

    TOTP totp = TOTP(secret: secretKeyOtp);

    var verificaCodigo = totp.verify(otp: code);
    if (verificaCodigo == false) {
      _mostrarMensagemDeErro("Código inválido");
    }
  }

  Future<void> colarCodigoOTP() async {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      String codigoColado = value?.text ?? "";
      if (codigoColado.isEmpty || codigoColado.length > otpSize) return;
      var codigoToChars = codigoColado.split("");
      for (var i = 0; i < codigoToChars.length; i++) {
        pinCodeList[i].text = codigoToChars[i];
      }
    });
  }
}

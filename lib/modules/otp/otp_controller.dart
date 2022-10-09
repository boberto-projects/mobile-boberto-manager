import 'package:auth_otp_test/modules/dio/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final List<TextEditingController> pinCodeList = [];
  int otpSize = 2;

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

  Future<void> validarCodigoOTP() async {
    _removerMensagemDeErro();
  }
}

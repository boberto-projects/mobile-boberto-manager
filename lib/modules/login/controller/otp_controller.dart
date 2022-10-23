import 'package:auth_otp_test/app_config.dart';
import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

///Responsável apenas por controlar o Widget OTP de forma reativa.
class OtpController extends GetxController {
  final List<TextEditingController> pinCodeList = [];
  String secretKeyOtp = AppConfig.otpKey;
  int otpSize = AppConfig.otpTamanho;
  int intervalo = AppConfig.otpIntervalo;

  OtpController() {
    gerarListaPinCode();
  }

  void gerarListaPinCode() {
    for (var i = 0; i < otpSize; i++) {
      pinCodeList.add(TextEditingController());
    }
  }

  void limparCodigoOTP() {
    pinCodeList.clear();
    gerarListaPinCode();
  }

  String get obterCodigoOTP => pinCodeList.fold(
      "", (previousValue, element) => previousValue + element.text);

  bool validarCodigoOTP(String codigo) {
    codigo = tratarCodigoOTP(codigo);
    if (codigo.isEmpty || codigo.length < otpSize) {
      return false;
    }
    TOTP totp =
        TOTP(secret: secretKeyOtp, interval: intervalo, digits: otpSize);

    bool verificaCodigo = totp.verify(otp: codigo);
    return verificaCodigo;
  }

  String tratarCodigoOTP(String codigo) {
    codigo = codigo.replaceAll(RegExp(r'[^0-9]'), '');
    if (codigo.isEmpty || codigo.length > otpSize) return "";
    return codigo;
  }

  void preencherCodigoOTP(String codigo) {
    String codigoTratado = tratarCodigoOTP(codigo);
    var codigoToChars = codigoTratado.split("");
    for (var i = 0; i < codigoToChars.length; i++) {
      pinCodeList[i].text = codigoToChars[i];
    }
  }

  Future<String> colarCodigoOTP() async {
    ClipboardData? clipBoard = await Clipboard.getData(Clipboard.kTextPlain);
    String codigoColado = clipBoard?.text ?? "";
    return codigoColado;
  }
}

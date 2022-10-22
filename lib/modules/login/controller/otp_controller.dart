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

  String get obterCodigoOTP => pinCodeList.fold(
      "", (previousValue, element) => previousValue + element.text);

  void limparCodigoOTP() {
    pinCodeList.clear();
    gerarListaPinCode();
  }

  bool validarCodigoOTP() {
    String code = obterCodigoOTP;
    if (code.isEmpty || code.length < otpSize) {
      return false;
    }
    TOTP totp =
        TOTP(secret: secretKeyOtp, interval: intervalo, digits: otpSize);
    bool verificaCodigo = totp.verify(otp: code);
    return verificaCodigo;
  }

  void preencherCodigoOTP(String codigo) {
    String codigoTratado = codigo.replaceAll(RegExp(r'[^0-9]'), '');
    if (codigoTratado.isEmpty || codigoTratado.length > otpSize) return;
    var codigoToChars = codigoTratado.split("");
    for (var i = 0; i < codigoToChars.length; i++) {
      pinCodeList[i].text = codigoToChars[i];
    }
  }

  Future<void> colarCodigoOTP() async {
    ClipboardData? clipBoard = await Clipboard.getData(Clipboard.kTextPlain);
    String codigoColado = clipBoard?.text ?? "";
    preencherCodigoOTP(codigoColado);
  }
}

import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app_config.dart';

class OtpService extends GetxService {
  final List<TextEditingController> pinCodeList = [];
  String otpChaveSecreta = AppConfig.otpKey;
  int otpTamanho = AppConfig.otpTamanho;
  int intervalo = AppConfig.otpIntervalo;

  OtpService() {
    _gerarListaPinCode();
  }

  void _gerarListaPinCode() {
    for (var i = 0; i < otpTamanho; i++) {
      pinCodeList.add(TextEditingController());
    }
  }

  void limparCodigoOTP() {
    pinCodeList.clear();
    _gerarListaPinCode();
  }

  String get obterCodigoOTP => pinCodeList.fold(
      "", (previousValue, element) => previousValue + element.text);

  bool validarCodigoOTP(String codigo) {
    codigo = tratarCodigoOTP(codigo);
    if (codigo.isEmpty || codigo.length < otpTamanho) {
      return false;
    }
    TOTP totp =
        TOTP(secret: otpChaveSecreta, interval: intervalo, digits: otpTamanho);

    bool verificaCodigo = totp.verify(otp: codigo);
    return verificaCodigo;
  }

  String tratarCodigoOTP(String codigo) {
    codigo = codigo.replaceAll(RegExp(r'[^0-9]'), '');
    if (codigo.isEmpty || codigo.length > otpTamanho) return "";
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

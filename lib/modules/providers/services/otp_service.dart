import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app_config.dart';

class OtpService extends GetxService {
  final List<TextEditingController> pinCodeList = [];
  String otpChaveSecreta = AppConfig.otpKey;
  int otpLength = AppConfig.otpLength;
  int interval = AppConfig.otpInterval;

  OtpService() {
    _generateFields();
  }

  void _generateFields() {
    for (var i = 0; i < otpLength; i++) {
      pinCodeList.add(TextEditingController());
    }
  }

  void clear() {
    pinCodeList.clear();
    _generateFields();
  }

  String get getCode => pinCodeList.fold(
      "", (previousValue, element) => previousValue + element.text);

  bool validate(String codigo) {
    codigo = _clearInvalidChars(codigo);
    if (codigo.isEmpty || codigo.length < otpLength) {
      return false;
    }
    TOTP totp =
        TOTP(secret: otpChaveSecreta, interval: interval, digits: otpLength);

    bool validCode = totp.verify(otp: codigo);
    return validCode;
  }

  String _clearInvalidChars(String codigo) {
    codigo = codigo.replaceAll(RegExp(r'[^0-9]'), '');
    if (codigo.isEmpty || codigo.length > otpLength) return "";
    return codigo;
  }

  void fill(String codigo) {
    String codigoTratado = _clearInvalidChars(codigo);
    var codeToChars = codigoTratado.split("");
    for (var i = 0; i < codeToChars.length; i++) {
      pinCodeList[i].text = codeToChars[i];
    }
  }

  Future<String> paste() async {
    ClipboardData? clipBoard = await Clipboard.getData(Clipboard.kTextPlain);
    String codePasted = clipBoard?.text ?? "";
    return codePasted;
  }
}

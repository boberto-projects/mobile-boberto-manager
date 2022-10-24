// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_otp_test/app_config.dart';
import 'package:flutter/material.dart';
import 'package:auth_otp_test/modules/login/sections/pin_box_section.dart';

class OtpWidget extends StatelessWidget {
  final void Function(String) codigoDigitado;
  final List<TextEditingController> listaCodigoOTP;

  const OtpWidget({
    Key? key,
    required this.listaCodigoOTP,
    required this.codigoDigitado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: AppConfig.otpTamanho,
        itemBuilder: (BuildContext context, int index) {
          return PinBoxSection(
              notificarMudanca: () {
                //    codigoDigitado(controller.obterCodigoOTP);
              },
              pinCodeController: listaCodigoOTP[index]);
        });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/login/sections/pin_box_section.dart';

class OtpWidget extends StatelessWidget {
  final OtpController controller;
  final void Function(String) codigoDigitado;

  const OtpWidget({
    Key? key,
    required this.controller,
    required this.codigoDigitado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.pinCodeList.length,
        itemBuilder: (BuildContext context, int index) {
          return PinBoxSection(
              notificarMudanca: () {
                codigoDigitado(controller.obterCodigoOTP);
              },
              pinCodeController: controller.pinCodeList[index]);
        });
  }
}

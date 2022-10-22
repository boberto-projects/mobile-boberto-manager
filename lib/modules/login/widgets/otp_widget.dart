import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/login/sections/pin_box_section.dart';
import 'package:flutter/material.dart';

class OtpWidget extends StatelessWidget {
  final OtpController controller;
  const OtpWidget({super.key, required this.controller});
      
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.pinCodeList.length,
        itemBuilder: (BuildContext context, int index) {
          return PinBoxSection(
              codigoDigitado: (value) {
                controller.validarCodigoOTP();
              },
              pinCodeController: controller.pinCodeList[index]);
        });
  }
}

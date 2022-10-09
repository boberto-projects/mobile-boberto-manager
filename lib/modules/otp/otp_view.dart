import 'package:auth_otp_test/modules/otp/otp_controller.dart';
import 'package:auth_otp_test/modules/otp/widgets/pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  final otpController = Get.find<OtpController>();

  OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Otp view"),
      ),
      body: Column(children: [
        Obx(
          () => Visibility(
              visible: otpController.mostrarErro.value,
              child: Text(otpController.mensagemErro.value)),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: otpController.pinCodeList.length,
              itemBuilder: (BuildContext context, int index) {
                return PinWidget(
                  pinCodeController: otpController.pinCodeList[index],
                );
              }),
        ),
        ElevatedButton(
          onPressed: otpController.validarCodigoOTP,
          child: const Text('Verificar código OTP'),
        ),
        ElevatedButton(
          onPressed: otpController.colarCodigoOTP,
          child: const Text('Colar código OTP'),
        ),
        ElevatedButton(
          onPressed: otpController.solicitarCodigoOTP,
          child: const Text('Solicitar código OTP'),
        )
      ]),
    );
  }
}

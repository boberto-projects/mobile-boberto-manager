import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/login/controller/login_controller.dart';
import 'package:auth_otp_test/modules/login/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOtpView extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  LoginOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Otp view"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Obx(
              () => Visibility(
                  visible: loginController.showError.value,
                  child: Text(loginController.messageError.value)),
            ),
            const Text(
                "Código OTP enviado para o número de celular cadastrado."),
            Expanded(
                child: Center(
                    child: OtpWidget(
                        codigoDigitado: (codigo) {
                          // loginController.validateOtpCode();
                        },
                        listaCodigoOTP:
                            loginController.otpService.pinCodeList))),
            Obx(() =>
                Text("Expira em ${loginController.intervalTimeResend.value}")),
            Obx(() => ElevatedButton(
                  onPressed: loginController.intervalTimeResend.value ==
                          AppConfig.otpInterval
                      ? loginController.sendAndWaitSMS
                      : null,
                  child: const Text('Reenviar'),
                )),
            ElevatedButton(
                onPressed: loginController.sendSMSCode,
                child: const Text('Reenviar')),

            // ElevatedButton(
            //   onPressed: loginController.colarCodigoOTP,
            //   child: const Text('Colar código'),
            // ),

            // ElevatedButton(
            //   onPressed: loginController.authenticator,
            //   child: const Text('Logar'),
            // )
          ]),
        ));
  }
}

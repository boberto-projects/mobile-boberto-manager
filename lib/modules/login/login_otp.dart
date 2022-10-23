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
                  visible: loginController.mostrarErro.value,
                  child: Text(loginController.mensagemErro.value)),
            ),
            const Text(
                "Código OTP enviado para o número de celular cadastrado."),
            Expanded(
                child: Center(
                    child: OtpWidget(
                        codigoDigitado: (codigo) {
                          // loginController.validarCodigoOTP();
                        },
                        controller: loginController.otpController))),
            Obx(() => Text("Expira em ${loginController.tempoExpiracao}")),
            // Obx(() => ElevatedButton(
            //       onPressed: loginController.tempoExpiracao.value ==
            //               AppConfig.otpIntervalo
            //           ? loginController.enviarCodigoSMS
            //           : null,
            //       child: const Text('Reenviar'),
            //     )),
            ElevatedButton(
                onPressed: loginController.enviarCodigoSMS,
                child: const Text('Reenviar')),

            ElevatedButton(
              onPressed: loginController.colarCodigoOTP,
              child: const Text('Colar código'),
            ),

            // ElevatedButton(
            //   onPressed: loginController.autenticar,
            //   child: const Text('Logar'),
            // )
          ]),
        ));
  }
}

import 'package:auth_otp_test/modules/login/controller/login_controller.dart';
import 'package:auth_otp_test/modules/login/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/otp_controller.dart';

class LoginOtpView extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  final otpController = Get.find<OtpController>();

  LoginOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login view"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Obx(
              () => Visibility(
                  visible: otpController.mostrarErro.value,
                  child: Text(otpController.mensagemErro.value)),
            ),
            Expanded(
                child: Center(
                    child: OtpWidget(
                        codigoDigitado: (codigo) {
                          print(codigo);
                        },
                        controller: otpController))),
            ElevatedButton(
              onPressed: loginController.autenticar,
              child: const Text('Logar'),
            )
          ]),
        ));
  }
}

import 'package:auth_otp_test/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login view"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Obx(
              () => Visibility(
                  visible: loginController.mostrarErro.value,
                  child: Text(loginController.mensagemErro.value)),
            ),
            TextField(
              controller: loginController.emailTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: loginController.senhaTextController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
            ElevatedButton(
              onPressed: loginController.autenticar,
              child: const Text('Login'),
            )
          ]),
        ));
  }
}

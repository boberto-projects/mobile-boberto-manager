import 'package:auth_otp_test/modules/login/controller/login_controller.dart';
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
                  visible: loginController.showError.value,
                  child: Text(loginController.messageError.value)),
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
              controller: loginController.passwordTextController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: loginController.authenticator,
              child: const Text('Logar'),
            )
          ]),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("OTP AUTH2 TESTES"),
        ),
        body: Column(children: [
          const Text("Teste de autenticação OTP"),
          ElevatedButton(
            onPressed: () => Get.toNamed("/autenticar"),
            child: const Text('Autenticação'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed("/otp"),
            child: const Text('Código OTP'),
          ),
        ]));
  }
}

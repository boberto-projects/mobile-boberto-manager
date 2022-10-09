import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Otp view"),
        ),
        body: Column(children: [
          const Text("Digite o código recebido por mensagem."),
          Row(children: const [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ])
        ]));
  }
}

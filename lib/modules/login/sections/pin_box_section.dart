import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinBoxSection extends StatelessWidget {
  final TextEditingController pinCodeController;
  final void Function() notificarMudanca;

  const PinBoxSection(
      {super.key,
      required this.pinCodeController,
      required this.notificarMudanca});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: TextField(
          textAlign: TextAlign.center,
          controller: pinCodeController,
          onChanged: (value) {
            notificarMudanca();
          },
          textInputAction: TextInputAction.next,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          style: const TextStyle(height: 1.0, color: Colors.black),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

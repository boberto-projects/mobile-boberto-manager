import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinWidget extends StatelessWidget {
  final TextEditingController pinCodeController;

  const PinWidget({super.key, required this.pinCodeController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: TextField(
        textAlign: TextAlign.center,
        controller: pinCodeController,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        style: const TextStyle(height: 1.0, color: Colors.black),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

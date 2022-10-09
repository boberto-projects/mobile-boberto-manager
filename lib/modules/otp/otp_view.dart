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
        body: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.all(30),
            itemCount: otpController.pinCodeList.length,
            itemBuilder: (BuildContext context, int index) {
              return PinWidget(
                pinCodeController: otpController.pinCodeList[index],
              );
            }));
  }
}

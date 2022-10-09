import 'package:auth_otp_test/modules/login/bindings/login_binding.dart';
import 'package:auth_otp_test/modules/otp/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/login/login_view.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(
          name: '/autenticar',
          page: () => LoginView(),
          bindings: [LoginBinding()]),
      GetPage(
          name: '/otp',
          page: () => const OtpView(),
          bindings: [LoginBinding()]),
    ],
  ));
}

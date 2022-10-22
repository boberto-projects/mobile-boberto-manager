import 'package:auth_otp_test/modules/home/home.dart';
import 'package:auth_otp_test/modules/login/bindings/login_binding.dart';
import 'package:auth_otp_test/modules/login/login_otp.dart';
import 'package:auth_otp_test/modules/perfil/bindings/perfil_binding.dart';
import 'package:auth_otp_test/modules/perfil/perfil_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/login/login_view.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const Home()),
      GetPage(
          name: '/autenticar',
          page: () => LoginView(),
          bindings: [LoginBinding()]),
      GetPage(
          name: '/loginotp',
          page: () => LoginOtpView(),
          bindings: [LoginBinding()]),
      GetPage(
          name: '/perfil',
          page: () => PerfilView(),
          bindings: [PerfilBinding()]),
    ],
  ));
}

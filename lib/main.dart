import 'package:auth_otp_test/modules/home/home.dart';
import 'package:auth_otp_test/modules/login/bindings/login_binding.dart';
import 'package:auth_otp_test/modules/otp/bindings/otp_binding.dart';
import 'package:auth_otp_test/modules/otp/otp_view.dart';
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
      GetPage(name: '/otp', page: () => OtpView(), bindings: [OtpBinding()]),
      GetPage(
          name: '/perfil',
          page: () => PerfilView(),
          bindings: [PerfilBinding()]),
    ],
  ));
}

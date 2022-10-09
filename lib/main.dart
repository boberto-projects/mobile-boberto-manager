import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/login/login_view.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const LoginView()),
    ],
  ));
}

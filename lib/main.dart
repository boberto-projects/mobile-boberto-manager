import 'package:auth_otp_test/firebase_options.dart';
import 'package:auth_otp_test/modules/home/home.dart';
import 'package:auth_otp_test/modules/login/bindings/login_binding.dart';
import 'package:auth_otp_test/modules/login/login_otp.dart';
import 'package:auth_otp_test/modules/perfil/bindings/perfil_binding.dart';
import 'package:auth_otp_test/modules/perfil/perfil_view.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print("firebase token" + fcmToken);
    // TODO: If necessary send token to application server.
    SecureStorage.write("fcmToken", fcmToken);
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const Home()),
      GetPage(
          name: '/authenticator',
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

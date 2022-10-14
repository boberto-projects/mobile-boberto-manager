import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");

  //mock
  LoginController() {
    emailTextController.text = "robertocpaes@gmail.com";
    senhaTextController.text = "Teste@123";
  }
  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mensagemErro.value = mensagem;
    mostrarErro.value = true;
  }

  Future<void> autenticar() async {
    _removerMensagemDeErro();
    final email = emailTextController.text;
    final senha = senhaTextController.text;
    if (email.isEmpty || senha.isEmpty) {
      _mostrarMensagemDeErro("Preencha todos os dados.");
      return;
    }
    final apiClient = ApiClient();
    try {
      var storage = SecureStorage();
      final request = AutenticarRequest(email: email, senha: senha);
      var response = await apiClient.autenticar(request);
      storage.escreverValor(
          AppConfig.usuarioTokenJWT, response.token as String);

      Get.toNamed("/otp");
    } catch (Exceptions) {
      _mostrarMensagemDeErro("Não foi possível autenticar.");
      print("Só pra lembrar: isso aqui não tá adicionando o token no baerer.");
    }
  }
}

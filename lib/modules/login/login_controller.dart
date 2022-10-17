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
  final apiClient = Get.find<ApiClient>();

  //mock
  LoginController() {
    emailTextController.text = "email@example.com";
    senhaTextController.text = "Teste@123";
  }
  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mostrarErro.value = true;
    mensagemErro.value = mensagem;
  }

  /// TODO: TEMOS QUE FASEAR O LOGIN.
  /// A autenticação usando OTP é opcional caso o usuário não a ative.
  /// Entretanto, o login no aplicativo será faseado entre login_view e otp_view

  Future<void> autenticar() async {
    _removerMensagemDeErro();
    final email = emailTextController.text;
    final senha = senhaTextController.text;
    if (email.isEmpty || senha.isEmpty) {
      _mostrarMensagemDeErro("Preencha todos os dados.");
      return;
    }
    final request = AutenticarRequest(email: email, senha: senha);
    await SecureStorage.deletarValor(AppConfig.autenticacaoJWTChave);
    var response = await apiClient.autenticar(request);
    response.fold((onError) async {
      _mostrarMensagemDeErro(onError.mensagem);
    }, (response) async {
      await SecureStorage.escreverValor(
          AppConfig.autenticacaoJWTChave, response.token);

      if (response.duplaAutenticacaoObrigatoria) {
        Get.toNamed("/otp");
      }

      Get.toNamed("/perfil");
    });
  }
}

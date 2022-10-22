import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();

  final Rx<bool> duplaAutenticacaoObrigatoria = Rx<bool>(false);
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  late OtpController otpController;
  final apiClient = Get.find<ApiClient>();

  //mock
  LoginController(OtpController? _otpController) {
    emailTextController.text = "robertocpaes@gmail.com";
    senhaTextController.text = "Teste@123";
    otpController = _otpController ?? OtpController();
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
    final request = AutenticarRequest(
        email: email, senha: senha, codigo: otpController.obterCodigoOTP);
    await SecureStorage.deletarValor(AppConfig.autenticacaoJWTChave);
    var response = await apiClient.autenticar(request);
    response.fold((onError) {
      if (onError.tipo == "codigo_otp_nao_informado") {
        Get.toNamed('/loginotp');
        return;
      }
      _mostrarMensagemDeErro(onError.mensagem);
    }, (response) async {
      SecureStorage.escreverValor(
          AppConfig.autenticacaoJWTChave, response.token);
      if (response.duplaAutenticacaoObrigatoria) {
        duplaAutenticacaoObrigatoria.value =
            response.duplaAutenticacaoObrigatoria;
      }
      Get.toNamed("/perfil");
    });
  }

  Future<void> autenticarComOTP() async {
    Get.toNamed('/loginotp');
  }
}

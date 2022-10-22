import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/enviar_otp/enviar_codigo_sms_request.dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();
  final Rx<int> tempoExpiracao = Rx<int>(AppConfig.otpIntervalo);

  final Rx<bool> duplaAutenticacaoObrigatoria = Rx<bool>(false);
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  late OtpController otpController;
  final apiClient = Get.find<ApiClient>();
  AltSmsAutofill? smsAutofill;

  //mock
  LoginController(OtpController? otpController) {
    emailTextController.text = "teste@robertinho.net";
    senhaTextController.text = "Teste@123";
    this.otpController = otpController ?? OtpController();
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
      _mostrarMensagemDeErro(onError.mensagem);

      if (onError.tipo == "codigo_otp_nao_informado") {
        Get.toNamed('/loginotp');
      }
      if (onError.tipo == "codigo_otp_invalido") {
        otpController.limparCodigoOTP();
        Get.toNamed('/loginotp');
      }
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

  Future<void> validarCodigoOTP() async {
    _removerMensagemDeErro();
    bool codigoValido = otpController.validarCodigoOTP();
    if (codigoValido) {
      await autenticar();
    } else {
      _mostrarMensagemDeErro("Falha no 2AUTH");
    }
  }

  ///emulador com datatime divergindo do servidor.
  ///vamos arrumar depois.
  Future<void> colarCodigoOTP() async {
    _removerMensagemDeErro();
    await otpController.colarCodigoOTP();
    bool codigoValido = otpController.validarCodigoOTP();
    if (codigoValido) {
      await autenticar();
    }
  }

  Future<void> aguardarSMS() async {
    final smsAutofill = AltSmsAutofill();
    String codigo = "";
    try {
      codigo = await smsAutofill.listenForSms ?? "";
    } on PlatformException {
      codigo = 'Failed to get Sms.';
    }

    otpController.preencherCodigoOTP(codigo);
  }

  @override
  void dispose() {
    smsAutofill?.unregisterListener();
    super.dispose();
  }
}

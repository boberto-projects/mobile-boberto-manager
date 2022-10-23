// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:auth_otp_test/app_config.dart';
import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/autenticar/autenticar_response.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/otp/enviar_otp/enviar_codigo_sms_request.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:auth_otp_test/modules/providers/storage/secure_storage.dart';
import 'package:dart_dash_otp/dart_dash_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController senhaTextController = TextEditingController();
  final Rx<int> tempoExpiracao = Rx<int>(AppConfig.otpIntervalo);
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);
  final Rx<bool> duplaAutenticacaoObrigatoria = Rx<bool>(false);
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  late OtpController otpController;
  final apiClient = Get.find<ApiClient>();
  Timer? aguardarSMSTimer;
  DateTime? expiraEm;

  //mock
  LoginController(OtpController? otpController) {
    emailTextController.text = "robertocpaes@gmail.com";
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
    response.fold((onError) async {
      _mostrarMensagemDeErro(onError.mensagem);
      otpController.limparCodigoOTP();
      if (onError.tipo == "codigo_otp_nao_informado") {
        Get.toNamed('/loginotp');
      }
    }, (response) async {
      SecureStorage.escreverValor(
          AppConfig.autenticacaoJWTChave, response.token);

      ///vamos tentar sincronizar o time utc do servidor com o emulador
      expiraEm = AutenticarResponse.parseDatetimeFromUtc(response.expiraEm);

      if (response.tipo == "token_temporario") {
        var perfilRequest = await apiClient.obterPerfil();
        perfilRequest.fold((onError) {
          _mostrarMensagemDeErro("Dados inválidos.");
        }, (obterPerfilResponse) {
          perfil.value = obterPerfilResponse;
          SecureStorage.deletarValor(AppConfig.autenticacaoJWTChave);
          Get.toNamed('/loginotp');
        });
        return;
      }

      if (response.duplaAutenticacaoObrigatoria) {
        duplaAutenticacaoObrigatoria.value =
            response.duplaAutenticacaoObrigatoria;
      }
      Get.toNamed("/perfil");
    });
  }

  // Future<void> validarCodigoOTP() async {
  //   _removerMensagemDeErro();
  //   bool codigoValido = otpController.validarCodigoOTP();
  //   if (codigoValido) {
  //     await autenticar();
  //   } else {
  //     _mostrarMensagemDeErro("Falha no 2AUTH");
  //   }
  // }

  ///emulador com datatime divergindo do servidor.
  ///vamos arrumar depois.
  Future<void> colarCodigoOTP() async {
    _removerMensagemDeErro();
    String codigo = await otpController.colarCodigoOTP();
    bool codigoValido = otpController.validarCodigoOTP(codigo);
    if (codigoValido) {
      await autenticar();
    }
  }

  Future<SmsMessage?> obterUltimoSMSRecebido() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = [];
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      messages = await query.querySms(
          count: 5, kinds: [SmsQueryKind.inbox], sort: true);
      // debugPrint('sms inbox messages: ${messages.length}');
    } else {
      await Permission.sms.request();
    }
    if (messages.isEmpty) {
      return null;
    }
    var mensagemFiltrada = messages.firstWhereOrNull(
        ((element) => element.body!.contains('ApiAuthBoberto')));

    return mensagemFiltrada;
  }

  void aguardarSMS() {
    aguardarSMSTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      var smsRecebido = await obterUltimoSMSRecebido();
      if (smsRecebido != null) {
        String bodyRecebido = smsRecebido.body ?? "";

        TOTP totp = TOTP(
            secret: AppConfig.otpKey,
            interval: AppConfig.otpIntervalo,
            digits: AppConfig.otpTamanho);
        String codigo = otpController.tratarCodigoOTP(bodyRecebido);
        bool codigoValido = totp.verify(otp: codigo, time: expiraEm);
        otpController.preencherCodigoOTP(bodyRecebido);
        // bool codigoValido = otpController.validarCodigoOTP(bodyRecebido);
        print("codigo_sms=" + codigo + " " + codigoValido.toString());

        if (codigoValido) {
          await autenticar();
          timer.cancel();
        }
      }
      tempoExpiracao.value--;
      if (tempoExpiracao.value == 0) {
        tempoExpiracao.value = AppConfig.otpIntervalo;
        timer.cancel();
      }
    });
  }

  void enviarCodigoSMS() async {
    aguardarSMS();
    var enviarCodigoSMSRequest = await apiClient.enviarCodigoSMS(
        EnviarCodigoSmsRequest(
            numeroCelular: perfil.value?.numeroCelular ?? ""));
    enviarCodigoSMSRequest.fold((onError) {
      _mostrarMensagemDeErro("Ocorreu um erro ao enviar SMS.");
    }, (enviarCodigoSMSResponse) {
      if (enviarCodigoSMSResponse) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
    aguardarSMSTimer?.cancel();
  }
}

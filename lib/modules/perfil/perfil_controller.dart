import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);

  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mensagemErro.value = mensagem;
    mostrarErro.value = true;
  }

  Future<void> obterPerfil() async {
    final apiClient = ApiClient();
    try {
      var response = await apiClient.obterPerfil();
      perfil.value = response;
      //  Get.toNamed("/otp");
    } catch (Exceptions) {
      _mostrarMensagemDeErro("Não foi possível autenticar.");
    }
  }
}

import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final Rx<bool> mostrarErro = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);
  final apiClient = Get.find<ApiClient>();

  @override
  onInit() async {
    super.onInit();
    await obterPerfil();
  }

  void _removerMensagemDeErro() {
    mostrarErro.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mensagemErro.value = mensagem;
    mostrarErro.value = true;
  }

  Future<void> obterPerfil() async {
    _removerMensagemDeErro();
    var response = await apiClient.obterPerfil();
    response.fold((onError) {
      _mostrarMensagemDeErro("Não foi possível autenticar.");
    }, (response) {
      perfil.value = response;
    });
  }
}

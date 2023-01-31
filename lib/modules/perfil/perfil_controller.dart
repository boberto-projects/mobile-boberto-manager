import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/apiClient/models/usuario/perfil_response..dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final Rx<bool> showError = Rx<bool>(false);
  final Rx<String> mensagemErro = Rx<String>("");
  final Rx<PerfilResponse?> perfil = Rx<PerfilResponse?>(null);
  final apiClient = Get.find<ApiClient>();

  @override
  onInit() async {
    super.onInit();
    await getProfile();
  }

  void _removerMensagemDeErro() {
    showError.value = false;
    mensagemErro.value = "";
  }

  void _mostrarMensagemDeErro(String mensagem) {
    mensagemErro.value = mensagem;
    showError.value = true;
  }

  Future<void> getProfile() async {
    _removerMensagemDeErro();
    var response = await apiClient.getProfile();
    response.fold((onError) {
      _mostrarMensagemDeErro("Não foi possível authenticator.");
    }, (response) {
      perfil.value = response;
    });
  }
}

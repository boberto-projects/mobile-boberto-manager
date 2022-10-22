import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/perfil/perfil_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:get/get.dart';

class PerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerfilController());
    Get.lazyPut(() => ApiClient());
  }
}

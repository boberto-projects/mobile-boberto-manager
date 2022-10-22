import 'package:auth_otp_test/modules/login/controller/login_controller.dart';
import 'package:auth_otp_test/modules/login/controller/otp_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(OtpController()));
    Get.lazyPut(() => ApiClient());

  }
}

import 'package:auth_otp_test/modules/login/controller/login_controller.dart';
import 'package:auth_otp_test/modules/providers/apiClient/api_client.dart';
import 'package:auth_otp_test/modules/providers/services/otp_service.dart';
import 'package:auth_otp_test/modules/providers/services/sms_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => ApiClient());
    //serviços
    Get.lazyPut(() => SMSService());
    Get.lazyPut(() => OtpService());
  }
}

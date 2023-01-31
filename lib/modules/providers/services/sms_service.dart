import 'dart:async';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SMSService extends GetxService {
  Timer? _waitSMSTimer;

  Future<void> waitSMS(void Function(String) callBackSMSRecebido) async {
    if (_waitSMSTimer != null) {
      return;
    }
    _waitSMSTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      var smsRecebido = await getLastSMS();
      if (smsRecebido != null) {
        String mensagemRecebida = smsRecebido.body ?? "";
        callBackSMSRecebido(mensagemRecebida);
        timer.cancel();
      }
    });
  }

  Future<SmsMessage?> getLastSMS() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = [];
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      messages = await query.querySms(
          count: 5, kinds: [SmsQueryKind.inbox], sort: true);
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
}

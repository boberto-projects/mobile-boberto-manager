import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'perfil_controller.dart';

class PerfilView extends StatelessWidget {
  final perfilController = Get.find<PerfilController>();

  PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sobre mim"),
        ),
        body: Obx(() => Column(children: [
              Text(perfilController.perfil.value?.nome ?? "Anônimo")
            ])));
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/beranda_bos_controller.dart';

class BerandaBosView extends GetView<BerandaBosController> {
  const BerandaBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('BerandaBosView'),
          centerTitle: true,
        ),
        body: Center(
            child: TextButton(
          onPressed: () {
            authC.logout();
          },
          child: Text("LOGOUT"),
        )));
  }
}

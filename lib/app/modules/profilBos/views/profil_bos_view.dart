import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profil_bos_controller.dart';

class ProfilBosView extends GetView<ProfilBosController> {
  const ProfilBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilBosView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProfilBosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

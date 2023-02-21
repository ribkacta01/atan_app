import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keranjang_bos_controller.dart';

class KeranjangBosView extends GetView<KeranjangBosController> {
  const KeranjangBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeranjangBosView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KeranjangBosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

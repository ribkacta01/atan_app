import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tugas_bos_controller.dart';

class TugasBosView extends GetView<TugasBosController> {
  const TugasBosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TugasBosView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TugasBosView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/olah_data_pegawai_controller.dart';

class OlahDataPegawaiView extends GetView<OlahDataPegawaiController> {
  const OlahDataPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OlahDataPegawaiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OlahDataPegawaiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

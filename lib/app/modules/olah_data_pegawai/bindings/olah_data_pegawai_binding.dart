import 'package:get/get.dart';

import '../controllers/olah_data_pegawai_controller.dart';

class OlahDataPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OlahDataPegawaiController>(
      () => OlahDataPegawaiController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/tugas_selesai_controller.dart';

class TugasSelesaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasSelesaiController>(
      () => TugasSelesaiController(),
    );
  }
}

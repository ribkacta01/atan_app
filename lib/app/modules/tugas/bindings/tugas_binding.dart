import 'package:get/get.dart';

import '../controllers/tugas_controller.dart';

class TugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasController>(
      () => TugasController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/tugas_bos_controller.dart';

class TugasBosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasBosController>(
      () => TugasBosController(),
    );
  }
}

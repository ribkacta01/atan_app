import 'package:get/get.dart';

import '../controllers/beranda_bos_controller.dart';

class BerandaBosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BerandaBosController>(
      () => BerandaBosController(),
    );
  }
}

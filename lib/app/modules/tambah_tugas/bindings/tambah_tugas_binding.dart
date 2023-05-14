import 'package:get/get.dart';

import '../controllers/tambah_tugas_controller.dart';

class TambahTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahTugasController>(
      () => TambahTugasController(),
    );
  }
}

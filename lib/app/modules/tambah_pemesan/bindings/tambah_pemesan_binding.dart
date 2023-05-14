import 'package:get/get.dart';

import '../controllers/tambah_pemesan_controller.dart';

class TambahPemesanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahPemesanController>(
      () => TambahPemesanController(),
    );
  }
}

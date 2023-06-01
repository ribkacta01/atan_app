import 'package:get/get.dart';

import '../controllers/tambah_foto_controller.dart';

class TambahFotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahFotoController>(
      () => TambahFotoController(),
    );
  }
}

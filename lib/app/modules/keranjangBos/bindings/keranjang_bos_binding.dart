import 'package:get/get.dart';

import '../controllers/keranjang_bos_controller.dart';

class KeranjangBosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangBosController>(
      () => KeranjangBosController(),
    );
  }
}

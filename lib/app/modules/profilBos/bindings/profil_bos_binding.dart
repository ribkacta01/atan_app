import 'package:get/get.dart';

import '../controllers/profil_bos_controller.dart';

class ProfilBosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilBosController>(
      () => ProfilBosController(),
    );
  }
}

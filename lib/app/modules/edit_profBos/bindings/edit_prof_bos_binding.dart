import 'package:get/get.dart';

import '../controllers/edit_prof_bos_controller.dart';

class EditProfBosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfBosController>(
      () => EditProfBosController(),
    );
  }
}

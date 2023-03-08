import 'package:get/get.dart';

import '../controllers/edit_prof_kry_controller.dart';

class EditProfKryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfKryController>(
      () => EditProfKryController(),
    );
  }
}

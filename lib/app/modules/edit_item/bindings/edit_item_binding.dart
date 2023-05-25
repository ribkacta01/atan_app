import 'package:get/get.dart';

import '../controllers/edit_item_controller.dart';

class EditItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditItemController>(
      () => EditItemController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/tambah_item_controller.dart';

class TambahItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahItemController>(
      () => TambahItemController(),
    );
  }
}

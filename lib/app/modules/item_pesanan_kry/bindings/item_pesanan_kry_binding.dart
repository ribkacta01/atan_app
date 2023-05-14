import 'package:get/get.dart';

import '../controllers/item_pesanan_kry_controller.dart';

class ItemPesananKryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemPesananKryController>(
      () => ItemPesananKryController(),
    );
  }
}

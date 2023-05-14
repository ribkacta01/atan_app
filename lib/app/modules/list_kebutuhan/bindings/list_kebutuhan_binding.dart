import 'package:get/get.dart';

import '../controllers/list_kebutuhan_controller.dart';

class ListKebutuhanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListKebutuhanController>(
      () => ListKebutuhanController(),
    );
  }
}

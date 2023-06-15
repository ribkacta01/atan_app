import 'package:atan_app/app/controller/fcm_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  final fcmC = Get.put(FCMController());

  var currentIndex = 0.obs;
  changePage(int i) {
    currentIndex.value = i;
  }

  var currentIndex2 = 0.obs;
  changePage2(int i) {
    currentIndex2.value = i;
    fcmC.notificationData = null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

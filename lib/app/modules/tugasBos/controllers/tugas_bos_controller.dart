import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TugasBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isChanged = (-1).obs;
  var isVisible = false.obs;

  void showWidgetWithDelay() async {}

  void toggleExpanded(int index) async {
    isChanged.value = isChanged.value == index ? -1 : index;
    if (isChanged.value == index) {
      await Future.delayed(Duration(milliseconds: 250));
      isVisible.value = true;
    }
  }
  //TODO: Implement TugasBosController

  final count = 0.obs;
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
